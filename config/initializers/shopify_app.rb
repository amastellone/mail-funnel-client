ShopifyApp.configure do |config|

  # config.application_name = "mailfunnel-client"
  # config.api_key = "6a440c4be7f0f0883519988f48bb8aae" # PRIVATE APP
  # config.secret = "0ff7181efe145655e3227e8a3cc3c9e4"  # PRIVATE APP

  config.application_name = "mail-funnel-client"
  config.api_key = "1a6193f91cd30bccf23b9167c97a9a20"
  config.secret = "3da0398c368b9a67901bea8135a10cc2"

  config.scope = "read_orders, read_products"
  config.embedded_app = true
end
