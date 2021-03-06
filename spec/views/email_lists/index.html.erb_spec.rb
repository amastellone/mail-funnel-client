require 'rails_helper'

RSpec.describe "email_lists/index", type: :view do
  before(:each) do
    assign(:email_lists, [
      EmailList.create!(
        :name => "Name",
        :description => "",
        :app_id => 2
      ),
      EmailList.create!(
        :name => "Name",
        :description => "",
        :app_id => 2
      )
    ])
  end

  it "renders a list of email_lists" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
