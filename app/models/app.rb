class App < RestModel
	has_many :jobs
	has_many :email_lists
	has_many :emails
	has_many :campaigns
	has_many :campaign_product_leads

	def myId()
		# TODO: Verify this works / get it working
		# Get Shopify App Name
		# name = ShopifyAPI::Store::name
		name = 'bluehelmet-dev'
		return App.where(name: name).first.id
	end

	# accepts_nested_attributes_for :campaigns
end
