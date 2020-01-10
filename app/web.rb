class Web < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set root: File.dirname(__FILE__) + '/..'
  set environment: (ENV['APP_ENV'] || :development).to_sym
  set public_folder: root + '/public'

  get '/' do
    'Bytely'
  end
end
