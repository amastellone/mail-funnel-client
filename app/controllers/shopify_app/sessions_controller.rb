module ShopifyApp
  class SessionsController < ApplicationController
    include ShopifyApp::SessionsConcern

    app = App.create(name: ShopifyApp::Shop::Name)

    app_config = MailFunnelConfig.create(name: "app_name", value: ShopifyApp::Shop::Name)

  end
end
