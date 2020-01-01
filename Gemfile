# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootsnap', '~> 1.4', require: false

gem 'bcrypt', '~> 3.1'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0'
gem 'sqlite3', '~> 1.4'
gem 'turbolinks', '~> 5.2'
gem 'webpacker', '~> 4.2'

gem 'tty-prompt', '~> 0.20', require: false

gem 'active_storage_validations', '~> 0.8'
gem 'activerecord-typedstore', '~> 1.3'
gem 'activevalidators', '~> 5.1'
gem 'cocoon', '~> 1.2'
gem 'devise', '~> 4.7'
gem 'devise_invitable', '~> 2.0'
gem 'image_processing', '~> 1.10'
gem 'jbuilder', '~> 2.9'
gem 'kaminari', '~> 1.1'
gem 'letter_avatar', '~> 0.3'
gem 'liquid', '~> 4.0'
gem 'meta-tags', '~> 2.13'
gem 'paranoia', '~> 2.4'
gem 'responders', '~> 3.0'
gem 'simple_form', '~> 5.0'

gem 'tzinfo-data', platforms: %i[jruby mingw mswin x64_mingw]

group :development do
  gem 'listen', '~> 3.2', require: false

  gem 'letter_opener', '~> 1.7'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0'
end

group :development, :test do
  gem 'rubocop', '~> 0.78', require: false
  gem 'rubocop-performance', '~> 1.5', require: false
  gem 'rubocop-rails', '~> 2.4', require: false
  gem 'rubocop-rspec', '~> 1.37', require: false

  gem 'dotenv-rails', '~> 2.7'
  gem 'pry-byebug', '~> 3.7'
end

group :test do
  gem 'capybara', '~> 3.30', require: false
  gem 'database_cleaner', '~> 1.7', require: false
  gem 'factory_bot_rails', '~> 5.1', require: false
  gem 'json-schema', '~> 2.8', require: false
  gem 'launchy', '~> 2.4', require: false
  gem 'rspec-rails', '~> 3.9', require: false
  gem 'simplecov', '~> 0.17', require: false
end

group :production do
  gem 'pg', '~> 1.2'
end
