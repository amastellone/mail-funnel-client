require 'rails_helper'

RSpec.describe "emails/index", type: :view do
  before(:each) do
    assign(:emails, [
      Email.create!(
        :name => "Name",
        :description => "",
        :app_id => 2
      ),
      Email.create!(
        :name => "Name",
        :description => "",
        :app_id => 2
      )
    ])
  end

  it "renders a list of emails" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
