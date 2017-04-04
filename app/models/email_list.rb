class EmailList < RestModel

	has_many :emails
	belongs_to :app
	# has_one :job
	belongs_to :campaign
	has_many :campaign_product_leads
end
