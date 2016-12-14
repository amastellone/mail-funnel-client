require 'rails_helper'

describe App do
	before do
		name = "bluehelmet-test"
		newapp = App.create(name: name)

		returnapp = App.where(name: name).first.id
	end

	subject { App.index }
	its(:name) { should be > -1  }
	its(:errors) { should be_empty }

end

# ** LEFT-OFF HERE **
# TODO: Finish creating tests for other models here
# TODO: These tests create special names with -test suffix, then find them, to check if ORM is working

# until $x > 5 do
list = EmailList.create(name:        "Main List " + $x.to_s,
                        description: "This is a great email list",
                        app_id:      app);

puts "Created List " + list.name.to_s
# until $x > Random.rand(3...15) do
email = Email.create(email:         Faker::Internet.email,
                     name:          Faker::Internet.name,
                     app_id:        app,
                     email_list_id: list.id);
puts list.name.to_s + ": Email Created " + email.email.to_s
# end
# $x +=1
# end

thislist = List.all.first

Campaign.all.each do |c|
	until $x > 2 do
		job = Job.create(frequency:           "execute_once",
		                 execute_time:        "1330",
		                 subject:             "Email subject",
		                 content:             "Email Contents",
		                 app_id:              app,
		                 campaign_identifier: c.name,
		                 hook_identifier:     c.hook_identifier,
		                 executed:            false,
		                 email_list_id:       List.offset(rand(List.count)).first
		)
		puts "Job Created for " + job.hook_identifier.to_s
	end
end