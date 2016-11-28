json.extract! hooks_constant, :id, :name, :identifier, :type, :hook_type, :created_at, :updated_at
json.url hooks_constant_url(hooks_constant, format: :json)