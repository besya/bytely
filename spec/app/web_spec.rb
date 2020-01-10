RSpec.describe 'Web application' do
  it 'should allow accessing to static files' do
    get '/static.txt'

    expect(last_response).to be_ok
  end

  describe '/' do
    it 'should allow accessing to the home page' do
      get '/'

      expect(last_response).to be_ok
    end
  end

  describe '/shorten' do
    let(:endpoint) { '/shorten' }
    let(:valid_url) { 'http://valid.url' }
    let(:invalid_url) { 'invalid_url' }

    let(:valid_params) { { url: valid_url } }
    let(:params_with_invalid_url) { { url: invalid_url } }

    it 'should return json object' do
      post endpoint

      expect(last_response.headers['Content-Type']).to include 'json'
      expect { JSON.parse last_response.body }.not_to raise_error(JSON::ParserError)
    end

    it 'should create and return Link object if params is valid' do
      post endpoint, valid_params

      link = JSON.parse last_response.body, symbolize_names: true

      expect(link).to include(:url, :token, :redirects)
      expect(link[:url]).to eq(valid_params[:url])
    end
  end
end
