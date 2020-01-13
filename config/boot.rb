require 'yaml'
require 'erb'
require 'json'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'maxmind/db'

ENV['APP_ENV'] ||= ENV['RACK_ENV'] || 'development'

ROOT_DIR = File.join(__dir__, '..')
APP_DIR = File.join(ROOT_DIR, 'app')

Dir[File.join(APP_DIR, '**/*.rb')].sort.each { |file| require file }

GEO = Geo.new(File.join(ROOT_DIR, 'db/geoip_countries.mmdb'))

require_relative '../app/web'
