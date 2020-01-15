class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  # Configuration
  configure :development do
    enable :logging
    register Sinatra::Reloader
  end

  set environment: (ENV['APP_ENV'] || :development).to_sym
end
