class App
	include Her::Model
	parse_root_in_json true, format: :active_model_serializers

	include_root_in_json true # Remove if anything
	# include_root_in_json :app
	#
	# < ActiveResource::Base
	# self.site = "http://localhost:3000"


	# include Her::JsonApi::Model
	# type :apps

	has_many :emails_lists
	# has_many :emails
end
