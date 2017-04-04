class BluehelmetUtil < ShopifyApp::AuthenticatedController

	def self.get_app_name

		domain = 'bluehelmet-dev.myshopify.com'

		# if session[:shopify_domain] != nil
		# 	return session[:shopify_domain]
		# end

		begin
			domain = ShopifyAPI::Shop.current.domain

			# if cookies.permanent[:shopify_app] == nil
			# 	cookies.permanent[:shopify_app] = "bluehelmet-dev.myshopify.com"
			# end

		rescue => e
			# logger.error(e.message)
		end

		return domain
	end

	def self.get_app_id
		return App.where(name: BluehelmetUtil.get_app_name).first.id
	end

	def self.get_app
		return App.where(name: BluehelmetUtil.get_app_name).first
	end

end