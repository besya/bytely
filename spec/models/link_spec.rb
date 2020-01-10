RSpec.describe Link, type: :model do
  describe 'validations' do
    subject { build(:link) }

    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:token) }

    it { should validate_uniqueness_of(:url) }
    it { should validate_uniqueness_of(:token) }

    it { should allow_value('http://google.com').for(:url) }

    bad_urls = %w[domain domain.suffix subdomain.suffix ttp://domain.suffix]
    it { should_not allow_value(bad_urls).for(:url) }
  end
end
