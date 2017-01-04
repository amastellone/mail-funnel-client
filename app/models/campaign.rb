class Campaign < RestModel

	has_one :hook
	belongs_to :app
	has_one :email_list
	has_many :jobs
end
