require 'rails_helper'

RSpec.describe EmailList, type: :model do

	it "Views all apps" do
		p "TEST: Index"
		lists = EmailList.all

		p lists.to_s

		# lists do |l|
		# 	p "App-Name: " + l.name.to_s
		# end

		# expect(app.id).to be > -1
	end

	it "Creates an app" do
		runthis = false
		if runthis == true
			p "TEST: Create An Email List"
			EmailList.create(name: "test-app-name-1")

			result = EmailList.where(name: "test-app-name-1")

			p "Result Email-List-ID: " + result.to_s
			# expect(app.id).to be > -1
		end
	end

end
