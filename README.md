# My Movie DB

The movies you love, go with you.

## Rails Backend API

### Requirements

- [Ruby 2.6](https://www.ruby-lang.org)

- [PostgreSQL](https://www.postgresql.org/)

### Database initialization

- Setup [database.yml](config/database.yml) with your PostgreSQL authentication data

- Open a terminal in the project's root folder

- Run `bin/bundle exec rails db:migrate` to create the database

- Run `bin/bundle exec rails db:seed` to initialize the database with seed data

### How to run the api

- Open a terminal in the project's root folder

- Run `bin/bundle exec rails s -b 0.0.0.0 -p 3003`

- The API will be available on <http://localhost:3003>

### How to run the test suite

- Open a terminal in the project's root folder

- Run `bin/bundle exec guard`
