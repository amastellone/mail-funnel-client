class App < Spyke::Base

include_root_in_json :app

has_many :jobs, class: "Job", uri: nil
has_many :emails_lists, class: "EmailsList", uri: nil
has_many :emails, class: "Email", uri: nil

	def myId()
		# TODO: Verify this works / get it working
		# Get Shopify App Name
		# name = ShopifyAPI::Store::name
		name = 'bluehelmet-dev'
		return App.where(name: name).first.id
	end

end
