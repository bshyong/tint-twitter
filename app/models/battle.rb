class Battle < ActiveRecord::Base
  has_many :battle_results
  has_many :hashtags, through: :battle_results
  attr_accessor :hashtag_one, :hashtag_two
  validates :hashtag_one, :hashtag_two, presence: true

  # callbacks
  after_create :set_up_hashtags

  def hashtag_first
    self.hashtags.first
  end

  def hashtag_second
    self.hashtags.last
  end

  def hashtag_count(hashtag)
    BattleResult.where(battle: self, hashtag: hashtag).first.count
  end

  private

  def set_up_hashtags
    h1 = Hashtag.where(name: self.hashtag_one).first_or_create
    h2 = Hashtag.where(name: self.hashtag_two).first_or_create
    self.hashtags << [h1, h2]
  end

end
