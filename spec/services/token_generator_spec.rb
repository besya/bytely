RSpec.describe TokenGenerator do
  it 'should generate a random string' do
    (7..9).each do |length|
      rule = /^[A-z0-9]{#{length}}$/
      token = described_class.call(length)

      expect(token).to match(rule)
    end
  end
end
