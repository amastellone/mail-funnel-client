class CampaignJob < ApplicationRecord
  belongs_to :campaign
  belongs_to :hooks_constant
end
