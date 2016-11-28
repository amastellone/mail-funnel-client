
namespace :Bluehelmet do
	# Database
	desc "Reset Database"
	task :reset => :environment do
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:schema:load"].invoke
	end
	desc "Seed Articles and Projects"
	task :seed => :environment do
		Rake::Task["Bluehelmet:import_wp"].invoke
		Rake::Task["db:data:load"].invoke
		Rake::Task["Bluehelmet:convert_projects"].invoke
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

	# HEROKU
	desc "Clear Heroku Cache"
	task :heroku_cache => :environment do
		heroku("run rake Bluehelmet:clear_cache")
	end
	desc "Upload Database to Heroku"
	task :push_db => :environment do
		heroku("pg:reset HEROKU_POSTGRESQL_GOLD")
		heroku("pg:push vkaloidis HEROKU_POSTGRESQL_GOLD --app vkaloidis")
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
