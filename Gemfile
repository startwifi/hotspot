source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5.0.1'
gem 'pg'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'

gem 'haml-rails'

# Authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-twitter'
gem 'omniauth-instagram'
gem 'omniauth-odnoklassniki', git: 'https://github.com/incubus/omniauth-odnoklassniki'

# Authorization
gem 'cancancan'

# Api wrappers
gem 'koala'
gem 'twitter'
gem 'odnoklassniki'

# Design
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# Statistics
gem 'browser'
gem 'chartkick'

# Tools
gem 'puma'
gem 'has_secure_token'
gem 'rest-client'
gem 'figaro'

# Uploads
gem 'carrierwave'
gem 'mini_magick'

# Others
gem 'groupdate'
gem 'redcarpet'
gem 'ransack'

# Router
gem 'mtik'

# Phone validator
gem 'phony_rails'

# OTP Generator
gem 'rotp'

# Localization
gem 'rails-i18n'
gem 'devise-i18n'

# Dev Notifications
gem 'exception_notification'
gem 'slack-notifier'
gem 'airbrake', '~> 6.2'
gem 'rollbar'

group :development, :test do
  gem 'pry-rails'
  gem 'byebug'
  gem 'spring'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
end

group :development do
  gem 'pry-doc'
  gem 'better_errors'
  gem 'spring-commands-rspec'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'overcommit', require: false
  # A static analysis security vulnerability scanner
  gem 'brakeman', require: false
  # Syntax checker for HAML
  gem 'haml-lint', require: false
  # Syntax checker for CSS
  gem 'ruby_css_lint', require: false
  # A Ruby static code analyzer
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end
