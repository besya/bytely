### Retrospective

- What went well?
    - Tests with rspec helped to avoid regression
    - Counter caches helped to denormalize a database
    - React-bootstrap helps to make UI changes quickly
    - Redis cache improves a response time for statistics endpoints
    
- What didn’t go well?
    - Free heroku allows to have two workers only. And this is why scheduler doesn't work on demo
    - For 10.000.000 requests per day needs more resources for Resque. It can be hot-fixed with additional servers for background jobs
    - UI should have unit and integration tests as well
    
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

Run workers ```bundle exec resque-pool```

Run scheduler ```bundle exec rake environment resque:scheduler```


#### Web App
Run in separate windows

```bundle exec puma -C config/puma.rb```

```bundle exec rake ui:start```


Web App will be available at `http://localhost:3000/` by default
Backend will be available at `http://localhost:8080/` by default

#### Resque workers
Web UI is available at `http://localhost:3000/resque/` be default

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
