RSpec.describe LinkCreator do
  let(:token_generator) { TokenGenerator }
  let(:valid_url) { 'http://valid.url' }
  let(:invalid_url) { 'invalid_url' }

  it 'should create and return Link with unique token if url is valid' do
    link = described_class.call(valid_url, token_generator)

    expect(link.token).not_to be_empty
    expect(link).to be_valid
    expect(link).to be_persisted
  end

  it 'should not create Link if url is invalid' do
    link = described_class.call(invalid_url, token_generator)

    expect(link.token).to be_nil
    expect(link).not_to be_valid
    expect(link).not_to be_persisted
  end

  it 'should return Link from database if url has already been taken' do
    expected_link = described_class.call(valid_url, token_generator)
    new_link = described_class.call(valid_url, token_generator)

    expect(new_link.id).to eq(expected_link.id)
    expect(new_link.token).to eq(expected_link.token)
  end

  it 'should regenerate token if it has already been taken' do
    double_generator = class_double(TokenGenerator)

    allow(double_generator).to receive(:call).and_return('TOKEN', 'TOKEN', 'EXPECTED')

    # Take the first token 'TOKEN'
    described_class.call(valid_url, double_generator)

    # Take the second token 'TOKEN', check if exists and take 'EXPECTED' token
    link = described_class.call('http://another.valid.url', double_generator)

    expect(link.token).to eq('EXPECTED')
  end
end
