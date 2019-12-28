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

gem 'image_processing', '~> 1.10'
gem 'jbuilder', '~> 2.9'

gem 'tzinfo-data', platforms: %i[jruby mingw mswin x64_mingw]

group :development do
  gem 'listen', '~> 3.1', require: false

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
end

group :production do
  gem 'pg', '~> 1.2'
end
