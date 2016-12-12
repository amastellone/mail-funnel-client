class EmailsList< Spyke::Base

	# include_root_in_json :emails_list
	include_root_in_json false

	has_many   :emails, class: "Email", uri: nil
	belongs_to :app, class: "App"
end
