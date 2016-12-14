json.extract! app, :id, :name, :builder_lock, :auth_token, :created_at, :updated_at
json.url app_url(app, format: :json)