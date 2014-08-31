require 'rails_helper'

RSpec.describe "battles/show", :type => :view do
  before(:each) do
    @battle = assign(:battle, Battle.create!(
      :boolean => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
