require 'rails_helper'

RSpec.describe App, type: :model do

	it "Views all apps" do
		p "Testing App Index"
		apps = App.all

		p apps
		# expect(app.id).to be > -1
	end

	it "Creates an app" do
		p "Testing Create App"

		apptitle = "test-app-name-2"

	  App.create(name: apptitle)

	  result = App.where(name: apptitle)

		puts "Result App-ID: " + result.to_s
	  expect(app.id).to be > -1
  end
end
