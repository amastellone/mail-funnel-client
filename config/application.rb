require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module MailFunnelClient
	class Application < Rails::Application

		config.web_console.whitelisted_ips = '173.170.66.40'

		config.logger = Logger.new(STDOUT)
		config.logger.level = Logger::ERROR


		config.autoload_paths << "#{Rails.root}/lib"
		config.autoload_paths << "#{Rails.root}/app/middleware"

		config.action_dispatch.default_headers                = {
			 'X-Frame-Options' => 'ALLOWALL'
		}

		# config.active_job.queue_adapter = :delayed_job

		# config.middleware.use, Rack::JWT::Auth,
		# config.middleware.use Magical::Unicorns

		# config.middleware.insert_before ActionDispatch::ParamsParser, "CatchJsonParseErrors"

		# config.active_record.raise_in_transactional_callbacks = false

		config.generators do |g|
			g.orm :active_record

			g.factory_girl true #  Automatic Replaces Fixtures
			g.test_framework :rspec
			# g.test_framework :test_unit, fixture: true
			# g.test_framework :test_unit, fixture: false

			g.template_engine :erb
			g.stylesheets true
			g.javascripts true
		end


		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.
	end
end
