class CountryIdentifier < Service
  def initialize(ip)
    @ip = ip
  end

  def call
    GEO.get(@ip)&.dig('country', 'names', 'en') || 'Unknown'
  end
end
