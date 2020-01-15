source 'https://rubygems.org'

ruby '2.6.3'

gem 'maxmind-db'
gem 'puma'
gem 'rack-contrib'
gem 'rake', '13.0.1'
gem 'resque'
gem 'resque-pool'
gem 'resque-retry'
gem 'sinatra', '2.0.7'
gem 'sinatra-activerecord', '2.0.14'
gem 'sinatra-contrib', '2.0.7'
gem "sinatra-cross_origin", "~> 0.3.1"

group :production, :development do
  gem 'pg'
end

group :test, :development do
  gem 'sqlite3', '1.4.0'
end

group :test do
  gem 'factory_bot'
  gem 'rack-test', '~>1.1.0'
  gem 'rspec', '3.9'
  gem 'shoulda-matchers'
end
