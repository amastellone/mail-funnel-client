class Email< Spyke::Base

	# include_root_in_json :email
	include_root_in_json false

	belongs_to :emails_lists, class: "EmailsList"

	# parse_root_in_json true, format: :active_model_serializers
	# include_root_in_json true # Remove if anything
	# include_root_in_json :email

	# collection_path "/email_lists/:email_list_id/emails"
end
