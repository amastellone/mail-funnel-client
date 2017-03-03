# MAIL FUNNEL - CLIENT SEEDS


# TODO: Finish the Config Model
MailFunnelConfig.create(name: "app_installed", value: "true")
MailFunnelConfig.create(name: "app_key", value: ENV['APP_KEY'])
MailFunnelConfig.create(name: "app_secret", value: ENV['APP_SECRET'])
MailFunnelConfig.create(name: "app_url", value: ENV['APP_URL'])
MailFunnelConfig.create(name: "app_scope", value: ENV['APP_SCOPE'])
MailFunnelConfig.create(name: "app_name", value: ENV['mail-funnel-client'])

MailFunnelConfig.create(name: "server_url", value: ENV['SERVER_URL'])

MailFunnelConfig.create(name: "dev_shop_name", value: "bluehelmet-dev")

rest_server_interaction = true
if rest_server_interaction

	# CLIENT INSTALL-SCRIPT:
	app_create = App.where(name: "bluehelmet-dev") # bluehelmet-dev.myshopifyapp.com

	if app_create.empty?
		app_create = App.create(name: "bluehelmet-dev")
		app        = app_create
		puts "App did not exist, created with id: " + app.id.to_s
	else
		app = app_create.first
		puts "App exists already, id: " + app.id.to_s
	end

	# EMAIL + EMAIL_LISTS

	# Default List
	default_list_check = EmailList.where(name: "Default", app_id: app.id)

	if default_list_check.empty?
		default_list_check = EmailList.create(name:        "Default",
		                                      description: "The default Mail-Funnel email list",
		                                      app_id:      app.id)
		defaultlist        = default_list_check
		puts "Default list does not exist, create it, id: " + defaultlist.id.to_s
	else
		defaultlist = default_list_check.first
		puts "Default list exists already, id: " + defaultlist.id.to_s
	end
	$x = 0 # Generate Emails for Default List
	until $x > Random.rand(3...15) do
		email = Email.create(email_address: Faker::Internet.email,
		                     name:          Faker::Name.name,
		                     app_id:        app,
		                     email_list_id: defaultlist.id)
		puts "Emails Created for List " + defaultlist.name + " - " + email.email_address
		puts defaultlist.name.to_s + ": Email Created " + email.email_address.to_s
		$x += 1
	end

	# Other Email Lists and Emails
	lists = Array.new
	$x    = 0
	until $x > Random.rand(2...3) do
		list = EmailList.create(name:        Faker::Lorem.sentence,
		                        description: Faker::Lorem.sentence,
		                        app_id:      app.id)
		lists << list.id
		$y = 0
		until $y > Random.rand(1...10) do
			email = Email.create(email_address: Faker::Internet.email,
			                     name:          Faker::Name.name,
			                     app_id:        app.id,
			                     email_list_id: list.id)
			puts list.name.to_s + ": Email Created " + email.email_address.to_s
			$y += 1
		end
		$x += 1
	end


	Hook.all.each do |h|
		$x = 0
		until $x >= Random.rand(0...2) do
			this_list       = lists.fetch(Random.rand(0...(lists.size-1)))
			c               = Campaign.new
			c.hook_id       = h.id
			c.name          = Faker::Lorem.sentence
			c.app_id        = app.id
			c.email_list_id = defaultlist.id
			c.save

			$y = 0
			# until $y >= Random.rand(0...1) do
			until $y >= 1 do
					j                   = Job.new
				j.hook_id           = h.id
				j.name              = Faker::Lorem.sentence
				j.hook_identifier   = h.identifier
				j.subject           = Faker::Lorem.sentence
				j.content           = Faker::Lorem.paragraphs(1)
				j.app_id            = app.id
				j.campaign_id       = c.id
				j.app_id            = app.id
				j.execute_frequency = "execute_now"
				j.execute_time      = Random.rand(3...5)
				j.execute_set_time  = DateTime.current
				j.executed = false
				j.save
				$y         += 1
			end
			$x += 1
		end
		# Execute_Frequency_Types
		# execute_now
		# execute_once
		# execute_twice
		# execute_thrice
		# execute_date 2015-01-10 = 20150110
	end
end