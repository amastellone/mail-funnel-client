class Hook < ApplicationRecord

	has_many  :campaigns
	has_many :jobs
end
