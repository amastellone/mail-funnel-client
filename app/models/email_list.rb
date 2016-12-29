class EmailList < RestModel

	has_many :emails
	belongs_to :app
	# has_one :job

end
