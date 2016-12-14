class EmailListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :app_id
end
