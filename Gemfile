source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'addressable', '~> 2.5'
gem 'breadcrumbs_on_rails'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise', '~> 4.7'
gem 'devise-i18n'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 1.1.3'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'rails-i18n', '~> 5.1'
gem 'sass-rails', '~> 5.0'
gem 'sentry-raven', '~> 2.9.0'
gem 'uglifier', '>= 1.3.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'coveralls', require: false
  gem 'rails-controller-testing'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.7'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'capybara-selenium'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.10'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
end
