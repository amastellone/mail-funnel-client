class EmailsList
	include Her::JsonApi::Model
	type :email_lists
	has_many :Email
end
