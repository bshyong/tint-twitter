require 'rails_helper'

RSpec.describe Battle, :type => :model do
  it "should have associated hashtags when created" do
    b = Battle.create(name: 'test', hashtag_one: 'one', hashtag_two: 'two')
    b.hashtags.count.should_eql 2
  end
  it "should validate presence of required fields" do
    Battle.new.should_not be_valid
    # need to have hashtag names
    Battle.new(name: 'test').should_not be_valid
    Battle.new(name: 'test', hashtag_one: 'one').should_not be_valid
    Battle.new(name: 'test', hashtag_one: 'one', hashtag_two: 'two').should be_valid
  end
end
