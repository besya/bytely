workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 8080
environment ENV['RACK_ENV'] || 'development'

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  if defined?(Resque)
    $redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://127.0.0.1:6379')
  end

  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || :development)
end
