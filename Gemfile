source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Authentication
gem 'devise'
# Authorization
gem 'cancan'

# Administration
gem 'activeadmin', github: 'gregbell/active_admin'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  # Add Spork test server for Rails
  gem 'spork-rails'
  # Add TestUnit support in Spork
  gem 'spork-testunit'

  # Init Spork configuration file
  # spork test --bootstrap # test hete is the directory for the testing framework
  # spork - run the DRb test server

  # Add Guard for Spork - this monitors configuration files on the filesystem and restarts the Spork server if there is a change
  gem 'guard-spork'
  # Init Guard configuration file
  # bundle exec guard init spork
  # Run Guard DRb server
  # bundle exec guard

  # Other useful gems for testing
  # gem 'cucumber-rails'
  # gem 'factory_girl_rails'
  # gem 'database_cleaner'

  gem 'dotenv-rails'

  gem 'rubocop'
end

group :production do
  gem 'rails_12factor'
end

platforms :ruby do
  # gems specific to linux
  gem 'unicorn'
end
