class RedirectRegister < Service
  def initialize(ip, link, ip2country)
    @ip = ip
    @link = link
    @ip2country = ip2country
  end

  def call
    Redirect.transaction do
      @link.redirects.create(attributes)
    end
  end

  private

  def attributes
    { ip: @ip, country: country, unique_redirect: unique_redirect }
  end

  def unique_redirect
    attributes = { link: @link, ip: @ip, country: country }
    @unique_redirect ||= UniqueRedirect.find_or_create_by(attributes)
  end

  def country
    @country ||= Country.find_or_create_by(name: country_name)
  end

  def country_name
    @ip2country.call(@ip)
  end
end
