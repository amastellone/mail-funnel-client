class Campaign < ApplicationRecord
  has_one :hooks_constant
  has_many   :jobs
end
