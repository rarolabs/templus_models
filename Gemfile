source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.0'

gem 'rails', '~> 5.2'

gem 'rack-attack', '~> 5'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '>= 3.5.2'
  gem 'factory_girl_rails'
  gem 'better_errors'
  gem 'ffaker'
  gem 'pry'
  gem 'awesome_print'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'hirb', '~> 0.7.3'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'simplecov', '~> 0.12.0'
end

# To use debugger
# gem 'debugger'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'wiselinks'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass', '3.3.7'
gem 'font-awesome-rails', '~> 4'

gem 'toastr-rails'
gem 'summernote-rails'

gem 'ransack'
gem 'kaminari'
gem 'simple_form'
gem 'nested_form'
gem 'rails-jquery-autocomplete'

#permission
gem 'cancancan'
gem 'devise'
gem 'rails-observers', github: "rails/rails-observers", branch: "master"

#worker
# gem 'sidekiq'

#rarocrud
gem 'carrierwave'
gem 'rmagick'

# Use Unicorn as the app server
gem 'unicorn'
gem 'capistrano-unicorn'

#Capistrano
gem 'capistrano'
gem 'rvm-capistrano',  require: false

#pdf
gem 'wicked_pdf'
