json.extract! email, :id, :name, :description, :app_id, :created_at, :updated_at
json.url email_url(email, format: :json)