class Web < Sinatra::Base
  # Configuration
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    use Rack::Static, index: 'public/index.html'
  end

  # Application constants
  set root: File.dirname(__FILE__) + '/..'
  set environment: (ENV['APP_ENV'] || :development).to_sym
  set public_folder: root + '/public'

  # Public endpoints

  post '/shorten' do
    content_type :json
    LinkCreator.call(params[:url], TokenGenerator).to_json
  end

  get '/popular' do
    Link.order(redirects_count: :desc).limit(10).to_json
  end

  get '/countries' do
    Country.order(redirects_count: :desc).to_json
  end

  get '/:token' do
    link = Link.find_by token: params[:token]

    if link
      Resque.enqueue RedirectRegisterJob, request.ip, link.id
      redirect to(link.url)
    else
      redirect to('/')
    end
  end
end
