class App < RestModel
has_many :jobs, :class_name => "Job"
has_many :email_lists, :class_name => "EmailList"
has_many :email, :class_name => "Email"

	def myId()
		# TODO: Verify this works / get it working
		# Get Shopify App Name
		# name = ShopifyAPI::Store::name
		name = 'bluehelmet-dev'
		return App.where(name: name).first.id
	end

end
