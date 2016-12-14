class EmailList < RestModel

	# include_root_in_json :emails_list
	# include_root_in_json false

	has_many :email, :class_name => "Email"
	belongs_to :app, :class_name => "App"
end
