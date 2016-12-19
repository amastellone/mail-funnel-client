json.extract! email_list, :id, :name, :description, :app_id, :created_at, :updated_at
json.url email_list_url(email_list, format: :json)