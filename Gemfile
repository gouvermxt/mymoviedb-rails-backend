source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Lint ruby code
gem 'rubocop', '~> 0.71.0', require: false
# Provide Ruby code completion in vscode
gem 'rcodetools'
# Simple, Heroku-friendly Rails app configuration using ENV and a single YAML file
gem 'figaro'
#A simple, standardized way to build and use Service Objects (aka Commands) in Ruby
gem 'simple_command'
# Simple, Fast, and Declarative Serialization Library for Ruby
gem 'blueprinter'
# A streaming JSON parsing and encoding library for Ruby (C bindings to yajl)
gem 'yajl-ruby', require: 'yajl'
# Makes http fun again! Ain't no party like a httparty, because a httparty don't stop.
gem 'httparty'
# Ruby Facets is the premiere collection of general purpose method extensions and standard additions for the Ruby programming language
gem 'facets', require: false
# Knock is an authentication solution for Rails API-only application based on JSON Web Tokens.
gem 'knock'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Support vscode debug
  gem 'ruby-debug-ide'
  gem 'debase'
  # Add Rspec and other test support libraries
  gem 'rspec-rails', '~> 3.8'
  # factory_bot is a fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails'
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
  gem 'database_cleaner'
  # Guard::RSpec automatically run your specs (much like autotest)
  gem 'guard-rspec', require: false
  # Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.
  gem 'vcr'
  # Library for stubbing and setting expectations on HTTP requests in Ruby.
  gem 'webmock'
  # Simple one-liner tests for common Rails functionality
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
