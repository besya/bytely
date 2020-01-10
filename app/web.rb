class Web < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    use Rack::Static, index: 'public/index.html'
  end

  set root: File.dirname(__FILE__) + '/..'
  set environment: (ENV['APP_ENV'] || :development).to_sym
  set public_folder: root + '/public'

  post '/shorten' do
    content_type :json
    LinkCreator.call(TokenGenerator, params[:url]).to_json
  end
end
