class JobLocal
	include ActiveModel::Serializers::JSON

	@@array = Array.new
	attr_accessor :job_id, :local_identifier,
	              :name, :hook_identifier,
	              :email_list_id, :subject,
	              :content, :execute_frequency,
	              :executed, :execute_time,
	              :app_id, :client_campaign


	def attributes
		{
			 'id' => job_id,
			 'local_identifier' => local_identifier,
			 'name' => name,
			 'hook_id' => hook_id,
			 'hook_identifier' => hook_identifier,
			 'email_list_id' => email_list_id,
			 'subject' => subject,
		   'content' => content,
		   'execute_frequency' => execute_frequency,
		   'executed' => executed,
		   'execute_time' => execute_time,
		   'app_id' => app_id,
		   'client_campaign' => client_campaign
		}
	end


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