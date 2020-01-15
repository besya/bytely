require './config/boot'

map('/resque')  { run Resque::Server }
map('/api')     { run ApiController }
map('/')        { run WebController }

