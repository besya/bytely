class RedirectRegisterJob
  include Sidekiq::Worker

  def perform(ip, link_id)
    link = Link.find_by(id: link_id)
    return unless link

    RedirectRegister.call(ip, link, CountryIdentifier)
  end
end
