# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'action_policy'
gem 'action_policy-graphql'
gem 'activerecord_where_assoc'
gem 'appsignal'
gem 'bootsnap', require: false
gem 'clearance'
gem 'doorkeeper'
gem 'dry-effects'
gem 'globalid'
gem 'graphql'
gem 'graphql-connections'
gem 'graphql-extras'
gem 'graphql_playground-rails'
gem 'graphql-rails_logger'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'redis', '~> 4.0'
gem 'rest-client'
gem 'rspec_api_documentation'
gem 'search_object_graphql'
gem 'sidekiq', '~> 7.0'
gem 'sprockets-rails'
gem 'state_machines-activerecord'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'debug', platforms: %i[mri mingw x64_mingw] # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'dotenv-rails'
  gem 'fabrication'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'simplecov'
end

group :development do
  gem 'annotate'
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'graphiql-rails'
  gem 'rubocop'
  gem 'rubocop-graphql'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console' # Use console on exceptions pages [https://github.com/rails/web-console]
end

group :test do # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock'
end
