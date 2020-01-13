class RedirectRegister < Service
  def initialize(ip, link, ip2country)
    @ip = ip
    @link = link
    @ip2country = ip2country
  end

  def call
    ActiveRecord::Base.transaction do
      @link.redirects.create ip: @ip, country: country
    end
  end

  private

  def country
    Country.find_or_create_by(name: country_name)
  end

  def country_name
    @ip2country.call(@ip)
  end
end
