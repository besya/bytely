RSpec.describe 'Web application' do
  it 'should allow accessing to the home page' do
    get '/'

    expect(last_response).to be_ok
  end
end
