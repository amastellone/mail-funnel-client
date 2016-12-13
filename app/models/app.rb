class App < RestModel

has_many :jobs, :class_name => "Job"
has_many :emails_lists, :class_name => "EmailsList"
has_many :emails, :class_name => "Email"

	def myId()
		# TODO: Verify this works / get it working
		# Get Shopify App Name
		# name = ShopifyAPI::Store::name
		name = 'bluehelmet-dev'
		return App.where(name: name).first.id
	end

end
