web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -r ./config/boot.rb -C ./config/sidekiq.yml
scheduler: bundle exec rake environment resque:scheduler
