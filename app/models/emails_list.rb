class EmailsList
	include Her::Model
	parse_root_in_json true, format: :active_model_serializers

	include_root_in_json true # Remove if anything
	# include_root_in_json :email

	# resource_path "/email_lists/:id"
	collection_path "/email_lists"

	# < ActiveResource::Base
	# self.site = "http://localhost:3000"


	# include Her::JsonApi::Model
	# type :email_lists

	has_many :emails
end
