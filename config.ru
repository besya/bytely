require './config/boot'

map('/sidekiq')  { run Sidekiq::Web }
map('/api')     { run ApiController }
map('/')        { run WebController }

