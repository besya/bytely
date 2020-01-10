### Development

#### Console
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

##### Run Web App
```bundle exec puma -C config/puma.rb```
