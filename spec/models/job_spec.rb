require 'rails_helper'

RSpec.describe Job, type: :model do

  describe 'Associations' do

    #Check to see if it belongs to a Campaign
    it 'belongs to a Campaign' do

      it { should belong_to(:campaign) }

    end

    #Check to see if it has relationship with a HooksConstant
    it 'has a relationship with a HooksConstant' do

      it { should have_one(:hook_constant) }

    end

  end

end
