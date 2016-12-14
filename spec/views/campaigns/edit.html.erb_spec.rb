require 'rails_helper'

RSpec.describe "campaigns/edit", type: :view do
  before(:each) do
    @campaign = assign(:campaign, Campaign.create!(
      :hook => 1,
      :hooks_constant_id => 1,
      :name => "MyString",
      :hook_identifier => "MyString"
    ))
  end

  it "renders the edit campaign form" do
    render

    assert_select "form[action=?][method=?]", campaign_path(@campaign), "post" do

      assert_select "input#campaign_hook[name=?]", "campaign[hook]"

      assert_select "input#campaign_hooks_constant_id[name=?]", "campaign[hooks_constant_id]"

      assert_select "input#campaign_name[name=?]", "campaign[name]"

      assert_select "input#campaign_hook_identifier[name=?]", "campaign[hook_identifier]"
    end
  end
end
