git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'

# Rails
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg'
gem 'puma'
gem 'rails', '>= 5.2.0'
gem 'sass-rails'
gem 'turbolinks'
gem 'uglifier'

#Frontend
gem 'bootstrap', '~> 4.0.0.beta'
gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap4'
gem 'jquery-rails'
gem 'slim'

#Common
gem 'devise'
gem 'simple_calendar', '~> 2.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen'
  gem 'reek'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end
