class Job < RestModel

	belongs_to :app
	has_one :email_list
	belongs_to :campaign
	has_one           :campaign_product_lead

end
