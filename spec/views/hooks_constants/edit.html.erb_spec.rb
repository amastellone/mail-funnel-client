require 'rails_helper'

RSpec.describe "hooks_constants/edit", type: :view do
  before(:each) do
    @hooks_constant = assign(:hooks_constant, HooksConstant.create!(
      :name => "MyString",
      :identifier => "MyString",
      :type => "",
      :hook_type => "MyString"
    ))
  end

  it "renders the edit hooks_constant form" do
    render

    assert_select "form[action=?][method=?]", hooks_constant_path(@hooks_constant), "post" do

      assert_select "input#hooks_constant_name[name=?]", "hooks_constant[name]"

      assert_select "input#hooks_constant_identifier[name=?]", "hooks_constant[identifier]"

      assert_select "input#hooks_constant_type[name=?]", "hooks_constant[type]"

      assert_select "input#hooks_constant_hook_type[name=?]", "hooks_constant[hook_type]"
    end
  end
end
