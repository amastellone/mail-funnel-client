class CampaignJob < ApplicationRecord
  belongs_to :campaign_id
  belongs_to :job_uuid
end
