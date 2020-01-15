RSpec.describe Link, type: :model do
  describe 'validations' do
    subject { build(:link) }

    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:token) }

    it { is_expected.to validate_uniqueness_of(:url) }
    it { is_expected.to validate_uniqueness_of(:token) }

    it { is_expected.to allow_value('http://google.com').for(:url) }

    bad_urls = %w[domain domain.suffix subdomain.suffix ttp://domain.suffix]
    it { is_expected.not_to allow_value(bad_urls).for(:url) }
  end
end
