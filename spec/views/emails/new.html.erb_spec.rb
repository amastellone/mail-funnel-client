require 'rails_helper'

RSpec.describe "emails/new", type: :view do
  before(:each) do
    assign(:email, Email.new(
      :name => "MyString",
      :description => "",
      :app_id => 1
    ))
  end

  it "renders new email form" do
    render

    assert_select "form[action=?][method=?]", emails_path, "post" do

      assert_select "input#email_name[name=?]", "email[name]"

      assert_select "input#email_description[name=?]", "email[description]"

      assert_select "input#email_app_id[name=?]", "email[app_id]"
    end
  end
end
