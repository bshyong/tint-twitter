class BattleResult < ActiveRecord::Base
  belongs_to :battle
  belongs_to :hashtag

  scope :active_results, -> { where(battle: Battle.where(active: true)) }

end
