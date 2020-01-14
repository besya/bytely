### Deployment
Automatic deploys to Heroku from `master` are enabled

Link to the app on Heroku: [https://bytelyapp.herokuapp.com](https://bytelyapp.herokuapp.com)

### Development
#### Setup a development environment
Change database settings 
`config/database.yml`

Run setup script ```bundle exec rake db:setup```

Run a web app ```bundle exec puma -C config/puma.rb```
Run workers ```bundle exec resque-pool```
Run scheduler ```bundle exec rake environment resque:scheduler```

#### Web App
Run in separate windows
```bundle exec puma -C config/puma.rb```
```bundle exec rake ui:start```

Web App will be Available at `http://localhost:3000/` by default

#### Resque workers
```bundle exec resque-pool```
Web UI is available at `http://localhost:3000/resque/` be default

#### Scheduler
```bundle exec rake environment resque:scheduler```

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


### UI
This command compiles the ui application to ./public folder
```rake ui:build```

Start UI in dev mode with hot reloading
```rake ui:start```

Add a new package using yarn
```rake ui:add package-name```

Run yarn install
```rake ui:install```
