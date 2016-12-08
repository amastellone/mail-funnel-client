# config/initializers/her.rb
Her::API.setup url: "http://localhost:3001" do |c|

	# c.use Faraday::Request::UrlEncoded
	# c.use Her::Middleware::DefaultParseJSON
	# c.use Faraday::Adapter::NetHttp
	# # middleware to make a json request by default
	# c.use Her::Middleware::AcceptJSON

	# # Request
	# c.use FaradayMiddleware::EncodeJson
	# # Response
	# c.use Her::Middleware::JsonApiParser
	# # Adapter
	# c.use Faraday::Adapter::NetHttp

	# Request
	# c.use Faraday::Request::UrlEncoded
	# c.use FaradayMiddleware::EncodeJson
	# c.use Her::Middleware::DefaultParseJSON
	# c.use Her::Middleware::AcceptJSON *

	# Response
	# c.use Her::Middleware::DefaultParseJSON *
	# c.use Her::Middleware::JsonApiParser

	# Adapter
	# c.use Faraday::Adapter::NetHttp
	# c.use Her::Middleware::AcceptJSON *

	c.use Faraday::Response::Logger, ActiveSupport::Logger.new(STDOUT) if Rails.env.development?

	# Request
	c.use Faraday::Request::UrlEncoded
	c.use Her::Middleware::AcceptJSON


	# Response
	c.use Her::Middleware::DefaultParseJSON

	# Adapter
	# c.use FaradayMiddleware::EncodeJson
	c.use Faraday::Adapter::NetHttp

	c.use Faraday::Response::Logger, ActiveSupport::Logger.new(STDOUT) if Rails.env.development?

end