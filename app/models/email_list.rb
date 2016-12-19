class EmailList < RestModel
	# protect_from_forgery with: :null_session
	# include_root_in_json :emails_list
	# include_root_in_json false

	has_many :emails
	belongs_to :app
end
