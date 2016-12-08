require 'test_helper'

class AppTest < ActiveSupport::TestCase

	test "should create App name on server and then again if you query it" do

		testname = "test-app-name"

		app = App.create(name: testname)

		puts 'App name created: ' + app.name

		response = App.where(name: testname)
		puts 'Rsponse name is: ' + response.name

		if response.name == testname
			assert true
		else
			assert false
		end

	end

end
