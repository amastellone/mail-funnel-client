class CampaignProductLead < RestModel
	belongs_to :app
	belongs_to :campaign
	belongs_to :job
	belongs_to :EmailList
	belongs_to :email
end
