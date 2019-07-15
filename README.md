# My Movie DB

The movies you love, go with you.

## Rails Backend API

### Requirements

- [Ruby 2.6](https://www.ruby-lang.org)

- [PostgreSQL](https://www.postgresql.org/)

### Setup

- Setup [database.yml](config/database.yml) with your PostgreSQL authentication data

- Open a terminal in the project's root folder

- Run `bin/bundle` to install the gems

- Run `bin/rails db:setup` to setup the database

- Create a configuration file containing the following:

  ```yaml
  # config/application.yml

  OMDB_API_KEY: <your OMDB API key (http://www.omdbapi.com/apikey.aspx)>
  FRONT_END_HOST: <the host where the frontend app is running (http://localhost:3000)>
  ```

### Run

- Open a terminal in the project's root folder

- Run `bin/rails s -b 0.0.0.0 -p 3003`

- The API will be available on <http://localhost:3003>

- Checkout the [API Docs](https://documenter.getpostman.com/view/1027148/SVSHqpEC)

- Setup the [frontend](https://github.com/gouvermxt/mymoviedb-react-frontend)

### Test

- Open a terminal in the project's root folder

- Run `bin/bundle exec rspec`

### Work in progress

- [x] movie search
- [x] authentication
- [ ] movie management
