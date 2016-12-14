class JobLocal
	@@array = Array.new
	attr_accessor :id, :local_identifier,
	              :name, :hook_identifier,
	              :email_list_id, :subject,
	              :content, :execute_frequency,
	              :executed, :execute_time


	def self.all_instances
		@@array
	end

	def all
		ObjectSpace.each_object(self).entries
	end

	# def initialize
	# 	@id = id,
	# 	@name = name
	# end

end