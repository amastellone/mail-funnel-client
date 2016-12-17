# MAIL FUNNEL - CLIENT SEEDS

# TODO: Finish the Config Model
MailFunnelConfig.create(name: "app_key", value: ENV['APP_KEY'])
MailFunnelConfig.create(name: "app_secret", value: ENV['APP_SECRET'])
MailFunnelConfig.create(name: "app_url", value: ENV['APP_URL'])
MailFunnelConfig.create(name: "app_scope", value: ENV['APP_SCOPE'])
MailFunnelConfig.create(name: "app_name", value: ENV['mail-funnel-client'])

MailFunnelConfig.create(name: "server_url", value: ENV['SERVER_URL'])

MailFunnelConfig.create(name: "dev_shop_name", value: "bluehelmet-dev")

# Cart
cart_hooks       = HookType.create(name: 'Cart')
cart_create_hook = HooksConstant.create(hook_type:  cart_hooks, name: 'Create',
                                        identifier: 'cart_create')
campaign         = Campaign.create(name:            'Cart / Create', hooks_constant_id: cart_create_hook.id,
                                   hook_identifier: cart_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

cart_update_hook = HooksConstant.create(hook_type: cart_hooks, name: 'Update', identifier: 'cart_update', hook_type_id: cart_hooks.id);
campaign = Campaign.create(name: 'Cart / Update', hooks_constant_id: cart_update_hook.id, hook_identifier: cart_update_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

cart_abandon_hook = HooksConstant.create(hook_type: cart_hooks, name: 'abandon', identifier: 'cart_abandon', hook_type_id: cart_hooks.id);
campaign = Campaign.create(name: 'Cart / Abandon', hooks_constant_id: cart_abandon_hook.id, hook_identifier: cart_abandon_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

# Checkout
checkout_hooks       = HookType.create(name: 'Checkout')
checkout_create_hook = HooksConstant.create(hook_type: checkout_hooks, name: 'Create', identifier: 'checkout_create', hook_type_id: checkout_hooks.id);
campaign = Campaign.create(name: 'Checkout / Create', hooks_constant_id: checkout_create_hook.id, hook_identifier: checkout_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

checkout_update_hook = HooksConstant.create(hook_type: checkout_hooks, name: 'Update', identifier: 'checkout_update', hook_type_id: checkout_hooks.id);
campaign = Campaign.create(name: 'Checkout / Update', hooks_constant_id: checkout_update_hook.id, hook_identifier: checkout_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

# Order
order_hooks       = HookType.create(name: 'Order')
order_create_hook = HooksConstant.create(hook_type: order_hooks, name: 'Create', identifier: 'order_create', hook_type_id: order_hooks.id);
campaign = Campaign.create(name: 'Order / Create', hooks_constant_id: order_create_hook.id, hook_identifier: order_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

order_update_hook = HooksConstant.create(hook_type: order_hooks, name: 'Update', identifier: 'order_update', hook_type_id: order_hooks.id);
campaign = Campaign.create(name: 'Order / Update', hooks_constant_id: order_update_hook.id, hook_identifier: order_update_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

rest_server_interaction = true
if rest_server_interaction

	# CLIENT AUTO-DEPLOY SCRIPT:

	# RestClient.get MailFunnelConfig.find("server_url") + 'apps/', {params: {name: 'bluehelmet-dev'}}
	# if !(app_create.empty?) && !(app_create.size > 1) && !(app_create.nil?) && app_create.first.name != "bluehelmet-dev"
	create_fresh = false

	app_create = App.where(name: "bluehelmet-dev")

	if create_fresh
		app_create = App.new(name: "bluehelmet-dev")
		app_create.save!
		app = app_create.id
		puts "App did not exist, created with id: " + app.to_s
	else
		app = app_create.first.id
		puts "App exists already, id: " + app.to_s
	end

	# RestClient.get MailFunnelConfig.find("server_url") + '/email_lists', {params: {app_id: app, name: 'Default'}}
	# if !(defaultlist.empty?) && !(defaultlist.size > 1) && !(defaultlist.nil?) && defaultlist.first.name != "Default"
	defaultlist = EmailList.where(name: "Default", app_id: app);

	if create_fresh
		defaultlist = EmailList.new(name:        "Default",
		                            description: "The default Mail-Funnel email list",
		                            app_id:      app);
		defaultlist.save!
		list = defaultlist
		 puts "Default list does not exist, create it, id: " + list.to_s
	else
		list = defaultlist.first
		puts "Default list exists already, id: " + list.id.to_s
	end

	# TEST DATA
	$x = 0
	until $x > Random.rand(3...15) do
		email = Email.create(email:         Faker::Internet.email,
		                     name:          Faker::Name.name,
		                     app_id:        app,
		                     email_list_id: list.id);
		puts "Emails Created for List " + list.name + " - " + email.email
		puts list.name.to_s + ": Email Created " + email.email.to_s
		$x += 1
	end

	$x = 0
	while $x <= 4 do
		job = Job.create(execute_frequency:   "execute_once",
		                 execute_time:        "1330",
		                 subject:             "Email subject",
		                 content:             "Email Contents",
		                 name:                Faker::Commerce.product_name,
		                 app_id:              app,
		                 campaign_identifier: campaign.hook_identifier,
		                 hook_identifier:     campaign.hook_identifier,
		                 client_campaign:     campaign.id,
		                 executed:            false,
		                 email_list_id:       list.id
		)
		# EmailList.offset(rand(EmailList.count)).first
		puts "OURS: Job Created for " + job.hook_identifier.to_s
		$x += 1
	end


end