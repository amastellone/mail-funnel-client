class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :hook, :hooks_constant_id, :name, :hook_identifier
end
