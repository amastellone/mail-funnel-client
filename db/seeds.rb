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

# Cart
# cart_hooks       = HookType.create(name: 'Cart')
# cart_create_hook = HooksConstant.create(hook_type:  cart_hooks, name: 'Create',
#                                         identifier: 'cart_create')
# campaign         = Campaign.create(name:            'Cart / Create', hooks_constant_id: cart_create_hook.id,
#                                    hook_identifier: cart_create_hook.identifier);
# puts "Campaign + Hook Created: " + campaign.name.to_s
#
# cart_update_hook = HooksConstant.create(hook_type: cart_hooks, name: 'Update', identifier: 'cart_update', hook_type_id: cart_hooks.id);
# campaign = Campaign.create(name: 'Cart / Update', hooks_constant_id: cart_update_hook.id, hook_identifier: cart_update_hook.identifier);
# puts "Campaign + Hook Created: " + campaign.name.to_s
#
# cart_abandon_hook = HooksConstant.create(hook_type: cart_hooks, name: 'abandon', identifier: 'cart_abandon', hook_type_id: cart_hooks.id);
# campaign = Campaign.create(name: 'Cart / Abandon', hooks_constant_id: cart_abandon_hook.id, hook_identifier: cart_abandon_hook.identifier);
# puts "Campaign + Hook Created: " + campaign.name.to_s
#
# # Checkout
# checkout_hooks       = HookType.create(name: 'Checkout')
# checkout_create_hook = HooksConstant.create(hook_type: checkout_hooks, name: 'Create', identifier: 'checkout_create', hook_type_id: checkout_hooks.id);
# campaign = Campaign.create(name: 'Checkout / Create', hooks_constant_id: checkout_create_hook.id, hook_identifier: checkout_create_hook.identifier);
# puts "Campaign + Hook Created: " + campaign.name.to_s
#
# checkout_update_hook = HooksConstant.create(hook_type: checkout_hooks, name: 'Update', identifier: 'checkout_update', hook_type_id: checkout_hooks.id);
# campaign = Campaign.create(name: 'Checkout / Update', hooks_constant_id: checkout_update_hook.id, hook_identifier: checkout_create_hook.identifier);
# puts "Campaign + Hook Created: " + campaign.name.to_s
#
# # Order
# order_hooks       = HookType.create(name: 'Order')
# order_create_hook = HooksConstant.create(hook_type: order_hooks, name: 'Create', identifier: 'order_create', hook_type_id: order_hooks.id);
# campaign = Campaign.create(name: 'Order / Create', hooks_constant_id: order_create_hook.id, hook_identifier: order_create_hook.identifier);
# puts "Campaign + Hook Created: " + campaign.name.to_s
#
# order_update_hook = HooksConstant.create(hook_type: order_hooks, name: 'Update', identifier: 'order_update', hook_type_id: order_hooks.id);
# campaign = Campaign.create(name: 'Order / Update', hooks_constant_id: order_update_hook.id, hook_identifier: order_update_hook.identifier);
# puts "Campaign + Hook Created: " + campaign.name.to_s

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
		until $x >= Random.rand(2...5) do
			this_list       = lists.fetch(Random.rand(0...(lists.size-1)))
			c               = Campaign.new
			c.hook_id       = h.id
			c.name          = Faker::Lorem.sentence
			c.app_id        = app.id
			c.email_list_id = defaultlist.id
			c.save

			$y = 0
			until $y >= Random.rand(5...7) do
				j                 = Job.new
				j.hook_id         = h.id
				j.name            = Faker::Lorem.sentence
				j.hook_identifier = h.identifier
				j.subject         = Faker::Lorem.sentence
				j.content         = Faker::Lorem.paragraphs(1)
				j.app_id          = app.id
				j.campaign_id     = c.id
				j.app_id          = app.id
				j.execute_frequency = "execute_now"
				j.execute_time      = Random.rand(3...5)
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