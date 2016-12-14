require "rails_helper"

RSpec.describe HooksConstantsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hooks_constants").to route_to("hooks_constants#index")
    end

    it "routes to #new" do
      expect(:get => "/hooks_constants/new").to route_to("hooks_constants#new")
    end

    it "routes to #show" do
      expect(:get => "/hooks_constants/1").to route_to("hooks_constants#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hooks_constants/1/edit").to route_to("hooks_constants#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hooks_constants").to route_to("hooks_constants#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hooks_constants/1").to route_to("hooks_constants#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hooks_constants/1").to route_to("hooks_constants#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hooks_constants/1").to route_to("hooks_constants#destroy", :id => "1")
    end

  end
end
