class HooksConstant < ApplicationRecord
  has_many :campaigns
  belongs_to :hook_type
end
