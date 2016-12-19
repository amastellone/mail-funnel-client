require 'rails_helper'

RSpec.describe "apps/new", type: :view do
  before(:each) do
    assign(:app, App.new(
      :name => "MyString",
      :builder_lock => false,
      :auth_token => "MyString"
    ))
  end

  it "renders new app form" do
    render

    assert_select "form[action=?][method=?]", apps_path, "post" do

      assert_select "input#app_name[name=?]", "app[name]"

      assert_select "input#app_builder_lock[name=?]", "app[builder_lock]"

      assert_select "input#app_auth_token[name=?]", "app[auth_token]"
    end
  end
end
