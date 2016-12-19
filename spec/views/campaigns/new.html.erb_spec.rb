require 'rails_helper'

RSpec.describe "campaigns/new", type: :view do
  before(:each) do
    assign(:campaign, Campaign.new(
      :hook => 1,
      :hooks_constant_id => 1,
      :name => "MyString",
      :hook_identifier => "MyString"
    ))
  end

  it "renders new campaign form" do
    render

    assert_select "form[action=?][method=?]", campaigns_path, "post" do

      assert_select "input#campaign_hook[name=?]", "campaign[hook]"

      assert_select "input#campaign_hooks_constant_id[name=?]", "campaign[hooks_constant_id]"

      assert_select "input#campaign_name[name=?]", "campaign[name]"

      assert_select "input#campaign_hook_identifier[name=?]", "campaign[hook_identifier]"
    end
  end
end
