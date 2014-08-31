require 'rails_helper'

RSpec.describe "battles/index", :type => :view do
  before(:each) do
    assign(:battles, [
      Battle.create!(
        :boolean => ""
      ),
      Battle.create!(
        :boolean => ""
      )
    ])
  end

  it "renders a list of battles" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
