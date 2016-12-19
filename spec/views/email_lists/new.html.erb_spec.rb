require 'rails_helper'

RSpec.describe "email_lists/new", type: :view do
  before(:each) do
    assign(:email_list, EmailList.new(
      :name => "MyString",
      :description => "",
      :app_id => 1
    ))
  end

  it "renders new email_list form" do
    render

    assert_select "form[action=?][method=?]", email_lists_path, "post" do

      assert_select "input#email_list_name[name=?]", "email_list[name]"

      assert_select "input#email_list_description[name=?]", "email_list[description]"

      assert_select "input#email_list_app_id[name=?]", "email_list[app_id]"
    end
  end
end
