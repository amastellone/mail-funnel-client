#Seeding

# Checkout
cart_create_hook = HooksConstant.create(name: 'Cart / Create', identifier: 'cart_create');
Campaign.create(name: 'Cart / Create Campaign', hooks_constant_id: cart_create_hook.id);

cart_update_hook = HooksConstant.create(name: 'Cart / Update', identifier: 'cart_update');
Campaign.create(name: 'Cart / Update Campaign', hooks_constant_id: cart_update_hook.id);

# Checkout
checkout_create_hook = HooksConstant.create(name: 'Checkout / Create', identifier: 'checkout_create');
Campaign.create(name: 'Checkout / Create Campaign', hooks_constant_id: checkout_create_hook.id);

checkout_update_hook = HooksConstant.create(name: 'Checkout / Update', identifier: 'checkout_update');
Campaign.create(name: 'Checkout / Update Campaign', hooks_constant_id: checkout_update_hook.id);

# Order
order_create_hook = HooksConstant.create(name: 'Order / Create', identifier: 'order_create');
Campaign.create(name: 'Order / Create Campaign', hooks_constant_id: order_create_hook.id);

order_update_hook = HooksConstant.create(name: 'Order / Update', identifier: 'order_update');
Campaign.create(name: 'Order / Update Campaign', hooks_constant_id: order_update_hook.id);