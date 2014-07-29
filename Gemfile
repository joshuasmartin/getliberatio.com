source 'https://rubygems.org'

ruby "2.1.1"

gem 'rails', '~>4.0.3'

gem 'haml'

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# Web server
gem 'unicorn'

# Heroku integration
gem 'rails_12factor', group: :production

# Pusher WebSockets
gem 'pusher'

# Currency and money
gem 'money-rails'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'pundit'

# Amazon Web Services
gem 'aws-sdk'

# Prevention for Heroku timeouts
gem "rack-timeout"