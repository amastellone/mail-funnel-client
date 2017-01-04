class EmailList < RestModel

	has_many :emails
	belongs_to :app
	# has_one :job
	belongs_to :campaign
end
