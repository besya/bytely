require './config/boot'

map '/resque' do
  run Resque::Server
end

run Web
