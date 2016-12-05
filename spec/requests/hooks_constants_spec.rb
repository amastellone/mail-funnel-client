require 'rails_helper'

RSpec.describe "HooksConstants", type: :request do
  describe "GET /hooks_constants" do
    it "works! (now write some real specs)" do
      get hooks_constants_index_path
      expect(response).to have_http_status(200)
    end
  end
end
