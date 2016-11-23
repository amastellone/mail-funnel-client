class HooksConstant < ApplicationRecord
  has_many :campaign_jobs
  has_many :campaigns
end
