class ApiController < ApplicationController
  configure do
    use Rack::PostBodyContentTypeParser
    register Sinatra::CrossOrigin
    enable :cross_origin
  end

  post '/shorten' do
    respond LinkCreator.call(params[:url], TokenGenerator)
  end

  get '/popular' do
    respond_links Link.order(redirects_count: :desc).limit(10)
  end

  get '/countries' do
    json Country.order(redirects_count: :desc)
  end

  # Needed for CORS
  options '*' do
    response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS'

    # Needed for React
    response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'

    halt :ok
  end

  private

  def respond(link)
    link.errors.empty? ? respond_link(link) : respond_error(link)
  end

  def respond_error(link)
    json errors: link.errors[:url].map { |e| "Url #{e}" }
  end

  def respond_link(link)
    json serialize_link(link)
  end

  def respond_links(data)
    json serialize_links(data)
  end

  def serialize_links(links)
    links.map(&method(:serialize_link))
  end

  def serialize_link(link)
    {
      url: link.url,
      short: URI.join(base_url, link.token),
      redirects_count: link.redirects_count,
      unique_redirects_count: link.unique_redirects_count
    }
  end
end
