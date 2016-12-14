require 'rails_helper'

RSpec.describe "email_lists/show", type: :view do
  before(:each) do
    @email_list = assign(:email_list, EmailList.create!(
      :name => "Name",
      :description => "",
      :app_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
