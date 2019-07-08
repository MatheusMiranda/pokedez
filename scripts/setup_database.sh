#!/bin/bash

while ! pg_isready -h rails-server-db -p 5432 -q -U postgres; do
  >&2 echo "Waiting for database service start properly!"
	sleep 1
done

>&2 echo "Postgres is up - executing command"

rails db:drop
rails db:create
rails db:migrate
rails db:seed
