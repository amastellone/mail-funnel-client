require 'rails_helper'

RSpec.describe "hooks_constants/index", type: :view do
  before(:each) do
    assign(:hooks_constants, [
      HooksConstant.create!(
        :name => "Name",
        :identifier => "Identifier",
        :type => "Type",
        :hook_type => "Hook Type"
      ),
      HooksConstant.create!(
        :name => "Name",
        :identifier => "Identifier",
        :type => "Type",
        :hook_type => "Hook Type"
      )
    ])
  end

  it "renders a list of hooks_constants" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Hook Type".to_s, :count => 2
  end
end
