class Email
	include Her::JsonApi::Model
	type :emails

	parse_root_in_json true, format: :active_model_serializers

	include_root_in_json true # Remove if anything
	# include_root_in_json :email

	collection_path "/email_lists/:email_list_id/emails"

	# Active Resource
	# < ActiveResource::Base
	# self.site = "http://localhost:3000"

	# Her (OLD)
	# include Her::JsonApi::Model
	# type :emails

	belongs_to :email_list
end
