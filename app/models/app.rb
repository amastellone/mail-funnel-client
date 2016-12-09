class App

	RestClient.post "http://example.com/resource", {'x' => 1}.to_json, {content_type: :json, accept: :json}



	def myId()
		# TODO: Verify this works / get it working
		# Get Shopify App Name
		# name = ShopifyAPI::Store::name
		name = 'bluehelmet-dev'
		return App.where(name: name).first.id
	end

end
