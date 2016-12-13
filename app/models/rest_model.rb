require 'active_resource'

class RestModel < ActiveResource::Base
	self.include_format_in_path = false
	self.site = "http://localhost:3001"
end
