class Job < RestModel

	#
	# attributes :id, :subject, :content,
	#            :email_list_id, :app_id, :campaign_identifier,
	#            :execute_frequency, :executed, :execute_time,
	#            :hook_identifier

	# uri 'jobs/(:id)'

	# include_root_in_json :jobs
	# include_root_in_json false

	belongs_to :app, :class_name => "App"
	has_one :emails_lists, :class_name => "EmailsList"

	# accepts_nested_attributes_for :emails_lists

	# parse_root_in_json true, format: :active_model_serializers
	# include_root_in_json true # Remove if anything
	# include_root_in_json :email

	# belongs_to :campaign
	# has_one	   :hook_constant
	# collection_path "/jobs"
end
