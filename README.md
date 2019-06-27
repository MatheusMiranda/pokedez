# Pokedez

# Run with docker

To run with docker you need first to config the database and create Pokemons.
```sh
sudo docker-compose run rails-server ./scripts/setup_database.sh
```

After running it you need to wait for the database to be populated, all the data is fetched from [Pokeapi](https://pokeapi.co/).

Next, start the services using the following command:

```sh
sudo docker-compose up
```

## Executing tests

```sh
sudo docker-compose run rails-server rspec
```

# Run locally

To run locally you need to install the following dependencies: 

* Ruby version: '2.5.5'
* Rais version: '~> 5.2.3'
* Postgres version: '10'

After installing the dependecies just configure the database and start the server:

Create database:

```sh
rail db:create
```

Apply migrations:

```sh
rails db:migrate
```

Run seeds to populate database:

```sh
rails db:seed
```

Execute rails server:

```sh
rails s
```
