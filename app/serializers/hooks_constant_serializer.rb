class HooksConstantSerializer < ActiveModel::Serializer
  attributes :id, :name, :identifier, :type, :hook_type
end
