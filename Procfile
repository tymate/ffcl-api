web: bundle exec rails server -p $PORT -e $RAILS_ENV -b 0.0.0.0
worker: bundle exec sidekiq -e $RAILS_ENV -C config/sidekiq.yml

postdeploy: bundle exec rake db:migrate
