class Email
	include Her::JsonApi::Model
	type :emails
	belongs_to :EmailLists
end
