LINKS_COUNT = 10

chars = ('a'..'z ').to_a.freeze
rand_length = -> { rand(3..7) }
rand_string = -> { (1..rand_length[]).map { chars.sample }.join }
new_url = -> { "http://#{rand_string[]}.#{rand_string[]}" }

urls = (1..LINKS_COUNT).map { new_url.call }

urls.each do |url|
  LinkCreator.call(url, TokenGenerator)
end

masks = {
    china: '1.0.63.',
    egypt: '23.218.228.',
    italy: '5.61.216.',
    japan: '1.33.0.',
    spain: '45.8.4.',
    tonga: '43.255.148.'
}

ips = masks.values.map do |mask|
  (1..rand(10)).map { |last| mask + last.to_s }
end.flatten

actual_links_count = Link.count
links = Link.all

ips.each do |ip|
  ActiveRecord::Base.transaction do
    links[1..rand(actual_links_count)].each { |link| RedirectRegister.call(ip, link, CountryIdentifier) }
  end
end
