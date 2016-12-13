require 'rails_helper'

RSpec.describe EmailsList, type: :model do

	it "Views all apps" do
		lists = EmailsList.all

		expect(app.id).to be >- 0
	end

	it "Creates a test Email List, finds it, then deletes it" do

		app = App.where(name: "bluehelmet-client-rspec-test-app").first

		expect(app).to exist
		expect(app.id).to be >= 0

		name = "test-app-name-" + Random.rand(1...9).to_s
		description = "bluehelmet test app description " + Random.rand(1...9).to_s

		EmailsList.create(name: name, description: description, app_id: app.id)


		result = EmailsList.where(app_id: app.id, name: name)

		expect(result).to exist
		expect(result.id).to be >= 0

		p "Result Email-List-ID: " + result.to_s
	end

end
