RSpec.describe CountryIdentifier do
  let(:ip_usa) { '165.23.12.23' }
  let(:ip_netherlands) { '23.9.12.23' }
  let(:invalid_ip) { 'invalid' }
  let(:unknown_ip) { '0.0.0.0' }

  it 'should return country name if ip exists in Geo database' do
    expect(described_class.call(ip_usa)).to eq('United States')
    expect(described_class.call(ip_netherlands)).to eq('Netherlands')
  end

  it 'should raise an error if ip has invalid format' do
    expect { described_class.call(invalid_ip) }.to raise_error(IPAddr::InvalidAddressError)
  end


  it 'should return "Unknown" if ip does not exist in Geo database' do
    expect(described_class.call(unknown_ip)).to eq('Unknown')
  end
end
