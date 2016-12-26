class EmailList < RestModel

	has_many :emails
	belongs_to :app

	schema do
		string 'name'
    string 'description'
	end

end
