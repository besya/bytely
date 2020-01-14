class CountryIdentifier < Service
  def initialize(ip)
    @ip = ip
  end

  def call
    $geo.get(@ip)&.dig('country', 'names', 'en') || 'Unknown'
  end
end
