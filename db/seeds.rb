# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'json'

pokeapi_base_url = 'https://pokeapi.co/api/v2/'

for pokemon_id in 1..151 do
  sleep(1)
  request_result = Net::HTTP.get(URI.parse(pokeapi_base_url + 'pokemon/' + pokemon_id.to_s))

  pokemon_data = JSON.parse(request_result)

  Pokemon.create(name: pokemon_data['name'])
end
