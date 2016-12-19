class Campaign < ApplicationRecord
  belongs_to :hooks_constant
  has_many   :jobs
end
