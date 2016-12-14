# Dummy api
class JSONParser < Faraday::Response::Middleware
	def parse(body)
		json = MultiJson.load(body, symbolize_keys: true)
		{
			 data: json[:result],
			 metadata: json[:metadata],
			 errors: json[:errors]
		}
	rescue MultiJson::ParseError => exception
		{ errors: { base: [ error: exception.message ] } }
	end
end

Spyke::Base.connection = Faraday.new(url: 'http://sushi.com') do |faraday|
	faraday.request   :json
	faraday.use       JSONParser
	faraday.adapter   Faraday.default_adapter
end
