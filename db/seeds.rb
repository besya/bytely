chars = ('a'..'z ').to_a.freeze
rand_length = -> { rand(3..7) }
rand_string = -> { (1..rand_length[]).map { chars.sample }.join }
new_url = -> { "http://#{rand_string[]}.#{rand_string[]}" }

urls = (1...1000).map { new_url.call }

urls.each do |url|
  LinkCreator.call(TokenGenerator, url)
end
