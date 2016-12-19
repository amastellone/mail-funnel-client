require 'rails_helper'

RSpec.describe "campaigns/index", type: :view do
  before(:each) do
    assign(:campaigns, [
      Campaign.create!(
        :hook => 2,
        :hooks_constant_id => 3,
        :name => "Name",
        :hook_identifier => "Hook Identifier"
      ),
      Campaign.create!(
        :hook => 2,
        :hooks_constant_id => 3,
        :name => "Name",
        :hook_identifier => "Hook Identifier"
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Hook Identifier".to_s, :count => 2
  end
end
