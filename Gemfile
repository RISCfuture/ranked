ruby '2.7.1'
source 'https://rubygems.org'

# FRAMEWORK
gem 'bootsnap'
gem 'puma'
gem 'rails', '6.0.2.2'

# MODELS
gem 'pg'

# CONTROLLERS
gem 'responders'

# VIEWS
gem 'jbuilder'
gem 'slim-rails'

# ASSETS
gem 'webpacker'

# ERROR TRACKING
gem 'bugsnag'

group :development do
  # ERRORS
  gem 'better_errors'
  gem 'binding_of_caller'

  # HOT RELOADING
  gem 'listen'
end

group :doc do
  gem 'redcarpet'
  gem 'yard'
end

group :test do
  # SPECS
  gem 'rails-controller-testing'
  gem 'rspec-rails', '4.0.0.beta.3'

  # FACTORIES
  gem 'factory_bot_rails'
  gem 'ffaker'

  # ENVIRONMENT
  gem 'database_cleaner'
  gem 'fakefs', require: 'fakefs/safe'
  gem 'timecop'
  gem 'webmock'
end

group :production do
  # CACHE
  gem 'redis'
end
