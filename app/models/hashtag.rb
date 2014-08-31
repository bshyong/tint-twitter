class Hashtag < ActiveRecord::Base
  has_many :battle_results
  has_many :battles, through: :battle_results
  before_save :downcase_name

  private

  def downcase_name
    self.name = self.name.downcase rescue nil
  end

end
