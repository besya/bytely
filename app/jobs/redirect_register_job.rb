class RedirectRegisterJob
  extend Resque::Plugins::Retry

  @queue = :redirects
  @retry_limit = 3
  @retry_delay = 10

  def self.perform(ip, link_id)
    link = Link.find_by(id: link_id)
    return unless link

    RedirectRegister.call(ip, link, CountryIdentifier)
  end
end
