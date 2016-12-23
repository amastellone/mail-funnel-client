ShopifyApp.configure do |config|

  # config.application_name = "mailfunnel-client"
  # config.api_key = "6a440c4be7f0f0883519988f48bb8aae" # PRIVATE APP
  # config.secret = "0ff7181efe145655e3227e8a3cc3c9e4"  # PRIVATE APP

  config.application_name = ENV['APP_NAME']
  config.api_key = ENV['APP_KEY']
  config.secret = ENV['APP_SECRET']

  # TODO: Verify app_scope works in shipify_app.rb and in .env
  config.scope = "read_orders, read_products"
  config.embedded_app = true
end
