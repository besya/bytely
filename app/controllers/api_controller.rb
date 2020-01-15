class ApiController < ApplicationController
  RESPONSE_CACHE_TTL_IN_SECONDS = 30

  configure do
    use Rack::PostBodyContentTypeParser
    register Sinatra::CrossOrigin
    enable :cross_origin
  end

  post '/shorten' do
    respond LinkCreator.call(params[:url], TokenGenerator)
  end

  get '/popular' do
    using_cache('popular') { serialize_links(popular_links) }
  end

  get '/countries' do
    using_cache('countries') { countries }
  end

  # Needed for CORS
  options '*' do
    response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS'

    # Needed for React
    response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'

    halt :ok
  end

  private

  def using_cache(key, seconds: RESPONSE_CACHE_TTL_IN_SECONDS, &block)
    $cache.get_or_set(key, seconds: seconds) { block.call.to_json }
  end

  def countries
    Country.order(redirects_count: :desc)
  end

  def popular_links
    Link.order(redirects_count: :desc).limit(10)
  end

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
      short: URI.join(base_url, link.token).to_s,
      redirects_count: link.redirects_count,
      unique_redirects_count: link.unique_redirects_count
    }
  end
end
