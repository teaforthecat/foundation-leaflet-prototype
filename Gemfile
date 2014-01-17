source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem 'mysql2'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

# gem 'foundation-rails', TODO: use '5.0.4' when it comes out
gem 'foundation-rails', github: 'Retistic/foundation-rails'

gem 'jbuilder', '~> 1.2'
gem 'haml'

gem 'bcrypt-ruby', '~> 3.1.2'
gem 'unicorn'

gem 'devise'
gem 'capybara'

group :development do
  gem "guard-rspec"
  gem "pry"
  gem "quiet_assets"
  gem "thin"
  gem 'capistrano', '~> 3.0'
end

group :development, :test do
  gem 'debugger'
  gem "zeus"
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem "factory_girl_rails"
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end
