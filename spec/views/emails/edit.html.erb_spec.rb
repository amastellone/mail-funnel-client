require 'rails_helper'

RSpec.describe "emails/edit", type: :view do
  before(:each) do
    @email = assign(:email, Email.create!(
      :name => "MyString",
      :description => "",
      :app_id => 1
    ))
  end

  it "renders the edit email form" do
    render

    assert_select "form[action=?][method=?]", email_path(@email), "post" do

      assert_select "input#email_name[name=?]", "email[name]"

      assert_select "input#email_description[name=?]", "email[description]"

      assert_select "input#email_app_id[name=?]", "email[app_id]"
    end
  end
end
