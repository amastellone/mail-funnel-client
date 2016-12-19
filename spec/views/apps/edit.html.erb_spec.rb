require 'rails_helper'

RSpec.describe "apps/edit", type: :view do
  before(:each) do
    @app = assign(:app, App.create!(
      :name => "MyString",
      :builder_lock => false,
      :auth_token => "MyString"
    ))
  end

  it "renders the edit app form" do
    render

    assert_select "form[action=?][method=?]", app_path(@app), "post" do

      assert_select "input#app_name[name=?]", "app[name]"

      assert_select "input#app_builder_lock[name=?]", "app[builder_lock]"

      assert_select "input#app_auth_token[name=?]", "app[auth_token]"
    end
  end
end
