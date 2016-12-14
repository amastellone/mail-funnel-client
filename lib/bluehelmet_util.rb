class BluehelmetUtil

	def get_shopify_session_app_name
		return clean_shopify_domain(session[:shopify_domain])
	end

	def clean_shopify_domain(input)
		input.split(".")

		if input.first == "www"
			return input.at(1)
		else
			return input.first
		end

	end

end