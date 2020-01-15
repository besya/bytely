RSpec.describe 'Web application' do
  it 'should allow accessing to static files' do
    get '/robots.txt'

    expect(last_response).to be_ok
  end

  describe '/' do
    it 'should allow accessing to the home page' do
      get '/'

      expect(last_response).to be_ok
    end
  end

  describe '/api/shorten' do
    let(:endpoint) { '/api/shorten' }
    let(:valid_url) { 'http://valid.url' }
    let(:invalid_url) { 'invalid_url' }

    let(:valid_params) { { url: valid_url } }
    let(:params_with_invalid_url) { { url: invalid_url } }

    it 'should return json object' do
      post endpoint

      expect(last_response.headers['Content-Type']).to include 'json'
      expect { JSON.parse last_response.body }.not_to raise_error
    end

    it 'should create and return Link object if params is valid' do
      post endpoint, valid_params

      link = JSON.parse last_response.body, symbolize_names: true

      expect(link).to include(:url, :short, :redirects_count, :unique_redirects_count)
      expect(link[:url]).to eq(valid_params[:url])
    end
  end

  describe '/api/popular' do
    before(:example) { create(:link) }

    it 'should return array of links' do
      get '/api/popular'

      links = JSON.parse last_response.body, symbolize_names: true

      expect(links).to be_a_kind_of(Array)
      expect(links.first).to include(:url, :short, :redirects_count, :unique_redirects_count)
    end
  end

  describe '/api/countries' do
    before(:example) { create(:country) }

    it 'should return array of countries' do
      get '/api/countries'

      countries = JSON.parse last_response.body, symbolize_names: true

      expect(countries).to be_a_kind_of(Array)
      expect(countries.first).to include(:name, :redirects_count, :unique_redirects_count)
    end
  end

  describe '/:token' do
    before(:example) { create(:link) }

    let(:valid_token) { 'TOKEN' }
    let(:invalid_token) { 'INVALID' }

    it 'should redirect to original url if token exists' do
      get "/#{valid_token}"

      link = Link.find_by(token: valid_token)

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to eq(link.url)
    end

    it 'should redirect to home page if token invalid' do
      get "/#{invalid_token}"

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to eq('http://example.org/')
    end
  end
end
