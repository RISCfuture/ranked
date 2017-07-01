ruby '2.4.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# FRAMEWORK
gem 'rails', '5.1.3'
gem 'puma'

# MODELS
gem 'pg'

# CONTROLLERS
gem 'responders'

# VIEWS
gem 'jbuilder'
gem 'slim-rails'

# ASSETS
gem 'webpacker'

group :development do
  # ERRORS
  gem 'better_errors'
  gem 'binding_of_caller'

  # HOT RELOADING
  gem 'listen'
end

group :doc do
  gem 'yard'
  gem 'redcarpet'
end

group :test do
  # SPECS
  gem 'rspec-rails'
  gem 'rails-controller-testing'

  # FACTORIES
  gem 'factory_girl_rails'
  gem 'ffaker'

  # ENVIRONMENT
  gem 'webmock'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'fakefs', require: 'fakefs/safe'
end
