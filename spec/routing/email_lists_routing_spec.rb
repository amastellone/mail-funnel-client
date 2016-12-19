require "rails_helper"

RSpec.describe EmailListsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/email_lists").to route_to("email_lists#index")
    end

    it "routes to #new" do
      expect(:get => "/email_lists/new").to route_to("email_lists#new")
    end

    it "routes to #show" do
      expect(:get => "/email_lists/1").to route_to("email_lists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/email_lists/1/edit").to route_to("email_lists#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/email_lists").to route_to("email_lists#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/email_lists/1").to route_to("email_lists#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/email_lists/1").to route_to("email_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/email_lists/1").to route_to("email_lists#destroy", :id => "1")
    end

  end
end
