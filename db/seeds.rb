#Seeding

# TODO: Finish the Config Model
security_key       = MailFunnelConfig.create(name: "security_key", value: "56156a1sdf0a3s55d0f3as5")
server_url_config  = MailFunnelConfig.create(name: "server_url", value: "http://localhost:3001")
app_config         = MailFunnelConfig.create(name: "app_name", value: "bluehelmet-dev")

# Checkout
cart_create_hook = HooksConstant.create(hook_type: 'cart', name: 'create', identifier: 'cart_create');
campaign = Campaign.create(name: 'Cart / Create', hooks_constant_id: cart_create_hook.id, hook_identifier: cart_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

cart_update_hook = HooksConstant.create(hook_type: 'cart', name: 'Update', identifier: 'cart_update');
campaign = Campaign.create(name: 'Cart / Update', hooks_constant_id: cart_update_hook.id, hook_identifier: cart_update_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

cart_abandon_hook = HooksConstant.create(hook_type: 'cart', name: 'abandon', identifier: 'cart_abandon');
campaign = Campaign.create(name: 'Cart / Abandon', hooks_constant_id: cart_abandon_hook.id, hook_identifier: cart_abandon_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

# Checkout
checkout_create_hook = HooksConstant.create(hook_type: 'checkout', name: 'Create', identifier: 'checkout_create');
campaign = Campaign.create(name: 'Checkout / Create', hooks_constant_id: checkout_create_hook.id, hook_identifier: checkout_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

checkout_update_hook = HooksConstant.create(hook_type: 'checkout', name: 'Update', identifier: 'checkout_update');
campaign = Campaign.create(name: 'Checkout / Update', hooks_constant_id: checkout_update_hook.id, hook_identifier: checkout_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

# Order
order_create_hook = HooksConstant.create(hook_type: 'order', name: 'Create', identifier: 'order_create');
campaign = Campaign.create(name: 'Order / Create', hooks_constant_id: order_create_hook.id, hook_identifier: order_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

order_update_hook = HooksConstant.create(hook_type: 'order', name: 'Update', identifier: 'order_update');
campaign = Campaign.create(name: 'Order / Update', hooks_constant_id: order_update_hook.id, hook_identifier: order_update_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

rest_server_interaction = false
if rest_server_interaction

	# Create
	app = App.where(name: "bluehelmet-dev").first.id

	# Generate default Email_List
	defaultlist = EmailList.create(name: 			"Default",
									description:    "The default Mail-Funnel email list",
									app_id:  		app);


	# until $x > Random.rand(3...15) do
		email = Email.create(email:         Faker::Internet.email,
			                     name:          Faker::Internet.name,
			                     app_id:        app,
			                     email_list_id: list.id);
		puts list.name.to_s + ": Email Created " + email.email.to_s
	# end


	# GENERATE TEST DATA
	generate_dummy_data = false
	if generate_dummy_data

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
				job = Job.create(frequency:     "execute_once",
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
	end

end