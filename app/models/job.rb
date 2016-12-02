class Job
	include Her::Model
	parse_root_in_json true, format: :active_model_serializers

	include_root_in_json true # Remove if anything
	# include_root_in_json :email

	# include Her::JsonApi::Model
	# type :jobs

	belongs_to :campaign
	has_one	   :hook_constant

	collection_path "/jobs"
end
