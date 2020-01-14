RSpec.describe RedirectRegister do
  let(:ip_usa) { '165.23.12.23' }
  let(:country_identifier) { CountryIdentifier }

  it 'should use ip2country dependency to detect country name' do
    link = create(:link)

    ip2country = double(country_identifier)
    expect(ip2country).to receive(:call) { 'USA' }.once

    described_class.call(ip_usa, link, ip2country)
  end

  it 'should increment redirect counters' do
    link = create(:link)

    register = -> { described_class.call(ip_usa, link, country_identifier) }

    expect { register.call }.to change { link.redirects_count }.by(1)
    expect { register.call }.to change { link.redirects.last.country.redirects_count }.by(1)
    expect(link.redirects_count).to eq link.redirects.count
    expect(link.redirects_count).to eq link.redirects.last.country.redirects_count
  end

  it 'should increment unique_redirect counters' do
    link = create(:link)

    register = -> { described_class.call(ip_usa, link, country_identifier) }

    expect { register.call }.to change { link.unique_redirects_count }.by(1)
    expect(link.unique_redirects_count).to eq link.unique_redirects.count
    expect(link.unique_redirects_count).to eq link.redirects.last.country.unique_redirects_count
  end

  it 'should create Country if does not exist' do
    link = create(:link)

    ip2country = double(country_identifier)
    allow(ip2country).to receive(:call) { 'USA' }

    register = -> { described_class.call(ip_usa, link, ip2country) }

    expect(Country.find_by(name: 'USA')).to be_nil

    expect { register.call }.to(change { Country.find_by(name: 'USA') }.from(nil).to(a_kind_of(Country)))
  end

  it 'should store request info' do
    link = create(:link)

    country_name = 'USA'
    ip2country = double(country_identifier)
    allow(ip2country).to receive(:call) { country_name }

    described_class.call(ip_usa, link, ip2country)

    redirect = link.redirects.last
    unique_redirect = redirect.unique_redirect

    expect(redirect.ip).to eq ip_usa
    expect(unique_redirect.ip).to eq ip_usa
    expect(redirect.country.name).to eq country_name
    expect(unique_redirect.country.name).to eq country_name
  end
end
