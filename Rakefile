require 'sinatra/activerecord/rake'
require 'redis'
require 'resque/tasks'
require 'resque/scheduler/tasks'

task :environment do
  require './config/boot'
end

namespace :ui do
  task :build do
    exec 'cd ui && yarn build'
  end

  task :start do
    exec 'cd ui && yarn start'
  end

  task :add do
    exec "cd ui && yarn add #{ARGV[1]}"
  end

  task :install do
    exec 'cd ui && yarn install'
  end
end

task :console do
  require 'irb'
  require './config/boot'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ARGV.clear
  IRB.start
end

task c: :console

task :setup do
  tasks = %w[create migrate test:prepare seed]
  tasks.each { |task_name| Rake::Task["db:#{task_name}"].invoke }
end

namespace :db do
  task :load_config do
    require './config/boot'
  end
end

namespace :resque do
  task :setup do
    require 'resque'
    Resque.redis = ENV['REDIS_URL'] || 'redis://127.0.0.1:6379'
  end

  task setup_schedule: :setup do
    require 'resque-scheduler'
  end

  task scheduler: :setup_schedule
end

task 'resque:pool:setup': :environment do
  ActiveRecord::Base.connection.disconnect!
  Resque::Pool.after_prefork do
    Resque.redis._client.reconnect
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || :development)
  end
end
