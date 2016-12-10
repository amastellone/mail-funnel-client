source 'https://rubygems.org'

gem 'htmlentities'

gem 'dotenv-rails', :require => 'dotenv/rails-now'

# Rest-Client
gem 'mime-types'
gem 'netrc'
gem 'http-cookie'
gem 'rest-client'

gem 'spyke'
gem 'jwt'    # https://github.com/jwt/ruby-jwt/blob/master/README.md

# Her
# Faraday Middleware for Her
gem 'faraday_middleware'
gem 'faraday', '~> 0.9.2'

# Bootstrap, Bootswatch, Font-Awesome, SASS
gem 'bootstrap_form'
gem 'bootswatch-rails'
gem "font-awesome-rails"
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '>= 3.2'

gem 'schema_auto_foreign_keys'
gem 'yaml_db'

gem 'shopify_app'
gem 'activeresource', :git => 'git://github.com/rails/activeresource.git'
# gem 'activeresource', github: 'rails/activeresource', branch: 'master'
gem 'active_model_serializers', '~> 0.10.0.rc2'

# RAILS
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

# DATABASE
# gem 'sqlite3'
gem 'pg'

# WEB SERVER
gem 'puma', '~> 3.0'

# INTERFACE
# gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
	gem 'rollbar'
end

group :development, :test do
	# Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug', platform: :mri
	gem 'rspec'
	gem 'rspec-rails'
end

group :development do
	# Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
	gem 'web-console'
	gem 'listen', '~> 3.0.5'
	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
	gem 'spring-watcher-listen', '~> 2.0.0'
	gem 'table_print'
	gem 'pry-rails'
end

group :test do
	gem "rspec-rails"
	gem "factory_girl_rails"
	# gem "capybara"
	# gem "selenium-webdriver"
	gem "database_cleaner"
	gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
\
# Gems appended using BASH '>' feature
gem 'rack-jwt'
