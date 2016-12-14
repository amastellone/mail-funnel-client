require 'rails_helper'

RSpec.describe "apps/index", type: :view do
  before(:each) do
    assign(:apps, [
      App.create!(
        :name => "Name",
        :builder_lock => false,
        :auth_token => "Auth Token"
      ),
      App.create!(
        :name => "Name",
        :builder_lock => false,
        :auth_token => "Auth Token"
      )
    ])
  end

  it "renders a list of apps" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Auth Token".to_s, :count => 2
  end
end
