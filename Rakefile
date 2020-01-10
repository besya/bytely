require 'sinatra/activerecord/rake'

task :console do
  require 'irb'
  require './config/boot'
  ARGV.clear
  IRB.start
end

task c: :console

namespace :db do
  task :load_config do
    require './config/boot'
  end
end
