class Job < RestModel

	belongs_to :app
	has_one :email_list
	belongs_to :campaign

end
