require 'tweetstream'

class TweetTracker

  def config
    TweetStream.configure do |config|
      config.consumer_key       = TWITTER_CONFIG[:app_id]
      config.consumer_secret    = TWITTER_CONFIG[:app_secret]
      config.oauth_token        = TWITTER_CONFIG[:access_token]
      config.oauth_token_secret = TWITTER_CONFIG[:token_secret]
      config.auth_method        = :oauth
    end
    yield
  end

  def stop
    puts "stopping the task"
    @client.stop
    exit 1
  end

  def initialize
    @client = self.config do
                TweetStream::Client.new
              end
  end

  def get_active_hashtags
    puts "getting active hashtags"
    hids = BattleResult.active_results.select('hashtag_id').uniq
    Hashtag.where(id: hids)
  end

  def process_tweet(tweet)
    puts "processing tweet #{tweet.id}"
    get_active_hashtags.each do |h|
      match = /\b#{h.name}\b/.match(tweet.text)
      # check regex for which tag(s) matches
      # increment count if regexp matches
      unless match.nil?
        BattleResult.active_results.where(hashtag: h.id).each do |br|
          br.increment(:count)
        end
      end
    end
  end

  def exclude_duplicates status
    @seen ||= {}
    if @seen[status.id]
      puts "Duplicate status detected; ignored"
    else
      @seen[status.id] = true
      yield(status)
    end
  end

  def restart
    @client.stop_stream
    tags = get_active_hashtags.collect(&:name)
    @client.track(tags) do |tweet|
      # defer so the event loop is not blocked
      EM.defer do
        exclude_duplicates(tweet) do
          process_tweet(tweet)
        end
      end
    end
  end
end

namespace :twitter do

  desc 'Get specific hashtagged tweets via Twitter streaming API'
  task :stream => :environment do
    client = TweetTracker.new
    trap("SIGINT") { client.stop }
    EM.run do
      client.restart
      # restart the loop every minute to refresh
      # the list of active hashtags
      EM::PeriodicTimer.new(60) do
        puts 'restarting'
        client.restart
      end
    end
  end

end