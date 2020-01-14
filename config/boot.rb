require 'yaml'
require 'erb'
require 'json'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require 'maxmind/db'
require 'resque/server'
require 'resque'
require 'resque-retry'

ENV['APP_ENV'] ||= ENV['RACK_ENV'] || 'development'

ROOT_DIR = File.join(__dir__, '..')
APP_DIR = File.join(ROOT_DIR, 'app')

Dir[File.join(APP_DIR, '**/*.rb')].sort.each { |file| require file }

require_relative 'initializers/redis'
require_relative 'initializers/resque'
require_relative 'initializers/geo'

require_relative '../app/web'
