#Seeding

# TODO: Finish the Config Model
MailFunnelConfig.create(name: "app_key", value: ENV['APP_KEY'])
MailFunnelConfig.create(name: "app_secret", value: ENV['APP_SECRET'])
MailFunnelConfig.create(name: "app_url", value: ENV['APP_URL'])
MailFunnelConfig.create(name: "app_scope", value: ENV['APP_SCOPE'])
MailFunnelConfig.create(name: "app_name", value: ENV['mail-funnel-client'])

MailFunnelConfig.create(name: "server_url", value: ENV['SERVER_URL'])

MailFunnelConfig.create(name: "dev_shop_name", value: "bluehelmet-dev")
MailFunnelConfig.create(name: "app_name", value: "bluehelmet-dev")

# Cart
cart_hooks = HookType.create(name: 'Cart')
cart_create_hook = HooksConstant.create(hook_type: cart_hooks, name: 'Create',
                                        identifier: 'cart_create')
campaign = Campaign.create(name: 'Cart / Create', hooks_constant_id: cart_create_hook.id,
                           hook_identifier: cart_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

cart_update_hook = HooksConstant.create(hook_type: cart_hooks, name: 'Update', identifier: 'cart_update', hook_type_id: cart_hooks.id);
campaign = Campaign.create(name: 'Cart / Update', hooks_constant_id: cart_update_hook.id, hook_identifier: cart_update_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

cart_abandon_hook = HooksConstant.create(hook_type: cart_hooks, name: 'abandon', identifier: 'cart_abandon', hook_type_id: cart_hooks.id);
campaign = Campaign.create(name: 'Cart / Abandon', hooks_constant_id: cart_abandon_hook.id, hook_identifier: cart_abandon_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

# Checkout
checkout_hooks = HookType.create(name: 'Checkout')
checkout_create_hook = HooksConstant.create(hook_type: checkout_hooks, name: 'Create', identifier: 'checkout_create', hook_type_id: checkout_hooks.id);
campaign = Campaign.create(name: 'Checkout / Create', hooks_constant_id: checkout_create_hook.id, hook_identifier: checkout_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

checkout_update_hook = HooksConstant.create(hook_type: checkout_hooks, name: 'Update', identifier: 'checkout_update', hook_type_id: checkout_hooks.id);
campaign = Campaign.create(name: 'Checkout / Update', hooks_constant_id: checkout_update_hook.id, hook_identifier: checkout_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

# Order
order_hooks = HookType.create(name: 'Order')
order_create_hook = HooksConstant.create(hook_type: order_hooks, name: 'Create', identifier: 'order_create', hook_type_id: order_hooks.id);
campaign = Campaign.create(name: 'Order / Create', hooks_constant_id: order_create_hook.id, hook_identifier: order_create_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

order_update_hook = HooksConstant.create(hook_type: order_hooks, name: 'Update', identifier: 'order_update', hook_type_id: order_hooks.id);
campaign = Campaign.create(name: 'Order / Update', hooks_constant_id: order_update_hook.id, hook_identifier: order_update_hook.identifier);
puts "Campaign + Hook Created: " + campaign.name.to_s

rest_server_interaction = true
if rest_server_interaction



end