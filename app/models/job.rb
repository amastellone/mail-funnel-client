class Job
	include Her::JsonApi::Model
	# type :jobs
	belongs_to :Campaign

	collection_path "/apps.json/:id"end
