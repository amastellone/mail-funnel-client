require 'rails_helper'

RSpec.describe MailFunnelConfig, type: :model do

  #MailFunnelConfig Creation Validation Tests
  describe 'Validations' do

    #Check validation with both timestamp attributes
    it 'is valid with both created_at and updated_at attribute' do

      config = MailFunnelConfig.new(created_at: DateTime.now, updated_at: DateTime.now)

      expect(config).to be_valid

    end

  end

end
