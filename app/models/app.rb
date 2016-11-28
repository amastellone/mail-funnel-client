class App < ApplicationRecord
	include Her::JsonApi::Model

	type :apps

	has_many :emails_lists
	has_many :emails
end
