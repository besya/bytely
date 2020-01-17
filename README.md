### Retrospective

As it should be able to process 10M requests per day it means 115 request per second, 
a current solution on free Heroku supports:
    - 208 http requests per second
    - 125 jobs per second

- What went well?
    - Tests with rspec helped to avoid regression
    - Counter caches helped to denormalize a database
    - React-bootstrap helps to make UI changes quickly
    - Redis cache improves a response time for statistics endpoints
    - Sidekiq works faster than Resque. 10_000 jobs was proceeded by Resque for 3m39s, by Sidekiq 0:30s
    
- What didn’t go well?
    - Using indexes on string fields like `url` can slow down inserts in future
    - Using counter_caches requires an additional update queries
    - UI should have a unit and integration tests as well
    - free Heroku database has a limit for rows ~ 1M, impossible to make good stress-testing with an emulation of a one month working for example
    
- If I had more time to work on this,
    - Stress-testing
    - Investigate a possibility to move analytics data to another storage
    - Write tests for UI
    - Make a documentation more detailed
    - Choose pure Rack instead of Sinatra
    - Choose pure css instead of Bootstrap
    

### Deployment
Automatic deploys to Heroku from `master` are enabled

Link to the app on Heroku: [https://bytelyapp.herokuapp.com](https://bytelyapp.herokuapp.com)

### Development
#### Setup a development environment
Change database settings 
`config/database.yml`

Run setup script ```bundle exec rake setup```

Run a web app ```bundle exec puma -C config/puma.rb```

Run workers ```bundle exec sidekiq -r ./config/boot.rb -C ./config/sidekiq.yml ```


#### Web App
Run in separate windows

```bundle exec puma -C config/puma.rb```

```bundle exec rake ui:start```


Web App will be available at `http://localhost:3000/` by default

Backend will be available at `http://localhost:8080/` by default

#### Background workers
Run workers ```bundle exec sidekiq -r ./config/boot.rb -C ./config/sidekiq.yml ```

Web UI is available at `http://localhost:8080/sidekiq/` be default

#### Console
Useful console like Rails Console

```rake console``` or ```rake c```

#### Database
##### Config location
`config/database.yml`

##### Create migration
```rake db:create_migration NAME=migration_name```

##### Apply migration
```rake db:migrate```

##### Rollback migration
```rake db:rollback```

#### Tests

##### Prepare database for tests
```rake db:test:prepare```

##### Run tests
```rspec```


#### UI
This command produces static files into /public folder

```rake ui:build```

Start UI in dev mode with hot reloading

```rake ui:start```

Add a new package using yarn

```rake ui:add package-name```

Run yarn install
```rake ui:install```
