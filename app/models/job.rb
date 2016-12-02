class Job < ActiveResource::Base
	self.site = "http://localhost:3000"

	# include Her::JsonApi::Model
	# type :jobs

	belongs_to :Campaign

	# collection_path "/apps.json/:id"
end
