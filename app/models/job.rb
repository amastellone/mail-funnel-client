class Job
	include Her::JsonApi::Model
	type :jobs
	belongs_to :Campaign
end
