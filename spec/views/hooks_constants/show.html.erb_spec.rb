require 'rails_helper'

RSpec.describe "hooks_constants/show", type: :view do
  before(:each) do
    @hooks_constant = assign(:hooks_constant, HooksConstant.create!(
      :name => "Name",
      :identifier => "Identifier",
      :type => "Type",
      :hook_type => "Hook Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Hook Type/)
  end
end
