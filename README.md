# Hashtag Battle


This web application based on the following technology stack:

* [Ruby 2.1.2][1]
* [Rails 4.1.4][2]
* [Puma][3]
* [PostgreSQL][4]
* [RSpec][5]
* [Twitter Bootstrap for Sass 3.2.0][6]
* [Autoprefixer][7]
* [Font Awesome 4.1.0][8]
* [HAML][9]

[1]: http://www.ruby-lang.org/en/
[2]: http://rubyonrails.org/
[3]: http://puma.io/
[4]: http://www.postgresql.org/
[5]: http://rspec.info/
[6]: http://getbootstrap.com/
[7]: http://github.com/ai/autoprefixer/
[8]: http://fontawesome.io/
[9]: http://haml.info/

This app is currently deployed on DigitalOcean; please ask for the URL to access a demo.

## Running the application
The application uses the TweetStream gem, which is based on EventMachine in order to consume tweets from the Twitter streaming API.

There is a rake task that will kick off the tweet consuming process, and it can be started by running `bundle exec rake twitter:stream`; use `nohup bundle exec rake twitter:stream &` to run in the background.  The standard output will be redirected to `nohup.out` in the current directory.

Once a hashtag battle is started, the battle will be active immediately. The rake task will check every 60 seconds for new hashtags and active Battles, in which case the counters for the hashtags will begin to increment.


