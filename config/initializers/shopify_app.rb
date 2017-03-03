ShopifyApp.configure do |config|

  config.application_name = ENV['APP_NAME']
  config.api_key = ENV['APP_KEY']
  config.secret = ENV['APP_SECRET']

  # TODO: Verify app_scope works in shipify_app.rb and in .env
  config.scope = "read_orders, read_products"
  config.embedded_app = true

  config.webhooks = [
     {topic: 'carts/update', address: 'mfserver.ngrok.io/api/carts_update'},
     {topic: 'carts/create', address: 'mfserver.ngrok.io/api/carts_create'}
  ]
end
