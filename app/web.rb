require 'sinatra/base'
require 'sinatra/reloader'

class Web < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
  end

  set :public_folder, File.dirname(__FILE__) + '/../public'

  get '/' do
    'Bytely'
  end
end