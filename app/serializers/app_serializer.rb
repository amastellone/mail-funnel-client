class AppSerializer < ActiveModel::Serializer
  attributes :id, :name, :builder_lock, :auth_token
end
