namespace :Bluehelmet do

	desc "Generate Jobs"
	task :seed_jobs => :environment do
		app       = App.where(name: "bluehelmet-dev").first
		Campaign.all.find_each do |campaign|
			$x = 0
			while $x <= 4 do
				job = Job.create(execute_frequency:   "execute_once",
				                 execute_time:        "1330",
				                 subject:             "Email subject",
				                 content:             "Email Contents",
				                 name:                Faker::Commerce.product_name,
				                 app_id:              app.id,
				                 campaign_identifier: campaign.hook_identifier,
				                 hook_identifier:     campaign.hook_identifier,
				                 client_campaign:     campaign.id,
				                 executed:            false,
				                 email_list_id:       1
				)
				# EmailList.offset(rand(EmailList.count)).first
				puts "OURS: Job Created for " + job.hook_identifier.to_s
				$x += 1
			end
		end
	end

	desc "Seed REST Data"
	task :seed_server => :environment do
		# GENERATE TEST DATA
		generate_dummy_data = true
		if generate_dummy_data

			# until $x > 5 do
			list = EmailList.create(name:        "Main List " + $x.to_s,
			                        description: "This is a great email list",
			                        app_id:      app)

			puts "Created List " + list.name.to_s
			# until $x > Random.rand(3...15) do
			email = Email.create(email:         Faker::Internet.email,
			                     name:          Faker::Name.name,
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
		end
	end

	desc "Generate Scaffolds for Existing Data"
	task :generate_scaffolds_phase_1 => :environment do
		Bundler.with_clean_env do

			# ** Look through Log Output or PIPE Output to File review what files were overridden / created /

			# Skip Model
			sh "rails g scaffold App name:string builder_lock:boolean auth_token:string --no-migration --no-assets --no-resource-route --skip"

			# Skip Model
			sh "rails g scaffold EmailList name:string description:test app_id:integer --no-migration --no-resource-route --skip"

			# Skip Controller, Model
			sh "rails g scaffold Email name:string description:test app_id:integer --no-migration --no-resource-route --no-assets --skip"

			# Skip Mode, Comment out Route
			sh "rails g scaffold Campaign hook:integer hooks_constant_id:integer name:string hook_identifier:string --no-migration --no-assets --no-assets  --skip"

			# Skip Model
			sh "rails g scaffold HooksConstant name:string identifier:string type:string hook_type:string --no-migration --no-assets --no-assets --no-resource-route  --skip"
		end
	end


	desc "Prepare Testing Seeding"
	task :prepare => :environment do
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["Bluehelmet:seed"].invoke # Seed Campaigns and Hooks
	end

	desc "Test Seeding"
	task :test => :environment do
		# Create
		railsapp = App.all

		puts railsapp.first.name

	end

	desc "Test Seeding"
	task :test3 => :environment do
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["Bluehelmet:seed"].invoke # Seed Campaigns and Hooks
		# Create
		railsapp = App.where(name: "bluehelmet-dev").first.id
	end

	desc "Test Seeding 2"
	task :test2 => :environment do
		Rake::Task["Bluehelmet:seed"].invoke # Seed
		list = EmailList.create(name:        "Main List " + $x.to_s,
		                        description: "This is a great email list",
		                        app_id:      app);

		puts "Created List " + list.name.to_s
		email = Email.create(email:         Faker::Internet.email,
		                     name:          Faker::Internet.name,
		                     app_id:        app,
		                     email_list_id: list.id);
		puts list.name.to_s + ": Email Created " + email.email.to_s

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
	end

	desc "Seed Configs + Campaigns"
	task :seed => :environment do

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
	end


	# Database
	desc "Reset Database"
	task :reset => :environment do
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:schema:load"].invoke
	end

	desc "Info"
	task :info => :environment do
		Bundler.with_clean_env do
			sh "rails --help | grep Bluehelmet: "
		end
		# Bundler.with_clean_env do
		# sh "rails --help | grep db: "
		# end
	end

	def heroku(cmd)
		Bundler.with_clean_env do
			sh "heroku " + cmd.to_s
		end
	end

	#  Clear Cache
	desc "Clear Cache"
	task :clear_cache => :environment do
		Rake::Task["tmp:clear"].invoke
		Rake::Task["tmp:cache:clear"].invoke
		Rake::Task["assets:clean"].invoke
	end
	desc 'Clear memcache'
	task clear_memcache: :environment do
		::Rails.cache.clear
		CACHE.flush
	end
end
