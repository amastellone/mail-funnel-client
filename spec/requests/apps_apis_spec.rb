require 'rails_helper'

RSpec.describe "AppsApis", type: :request do
  describe "GET /apps_apis" do
    it "works! (now write some real specs)" do
      get apps_apis_path
      expect(response).to have_http_status(200)
    end
  end
end
