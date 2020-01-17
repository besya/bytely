require 'sinatra/activerecord/rake'
require 'redis'

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
