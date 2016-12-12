class Job < Spyke::Base
	attributes :frequency, :subject, :content, :email_list_id, :app_id, :campaign_identifier, :executed, :hook_identifier

	# uri 'jobs/(:id)'

	# include_root_in_json :jobs
	include_root_in_json false

	belongs_to :apps, class: "App"
	has_one :emails_lists, class: "EmailsList", uri: nil
	accepts_nested_attributes_for :emails_lists

	# parse_root_in_json true, format: :active_model_serializers
	# include_root_in_json true # Remove if anything
	# include_root_in_json :email

	# belongs_to :campaign
	# has_one	   :hook_constant
	# collection_path "/jobs"
end
