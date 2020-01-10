require 'yaml'
require 'erb'
require 'json'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'

ROOT_DIR = File.join(__dir__, '..')
APP_DIR = File.join(ROOT_DIR, 'app')

%w[models].map do |dir|
  Dir[File.join(APP_DIR, dir, '*.rb')].sort.each { |file| require file }
end

require_relative '../app/web'
