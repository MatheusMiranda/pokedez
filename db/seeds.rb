require 'net/http'
require 'json'
require 'open-uri'

def process_evolution_chain(chain_data)
  return if chain_data['evolves_to'].empty?

  base_pokemon_name = chain_data['species']['name']
  evolution_pokemons = []

  chain_data['evolves_to'].each do |evolution|
    evolution_pokemons << evolution['species']['name']
    process_evolution_chain(evolution)
  end

  base_pokemon = Pokemon.find_by(name: base_pokemon_name)
  if base_pokemon != nil
    base_pokemon.evolutions = evolution_pokemons
    base_pokemon.save
  end
end

def get_evolution_chains
  evolution_chain_base_url = 'https://pokeapi.co/api/v2/evolution-chain/'
  for chain_id in 1..78 do
    chain_result = JSON.parse(Net::HTTP.get(URI.parse(evolution_chain_base_url + chain_id.to_s)))['chain']

    process_evolution_chain(chain_result)
  end
end

def create_pokemon(pokemon_data)
  puts "Creating pokemon " + pokemon_data['name']

  pokemon_types = []
  pokemon_data['types'].each do |type|
    pokemon_types << type['type']['name']
  end

  pokemon_name = pokemon_data['name']
  pokemon_sprite_url = pokemon_data['sprites']['front_default']

  Pokemon.create(name: pokemon_name, types: pokemon_types, photo: URI.parse(pokemon_sprite_url))
end

def get_pokemons
  pokeapi_base_url = 'https://pokeapi.co/api/v2/'

  for pokemon_id in 1..151 do
    sleep(1)
    result = Net::HTTP.get(URI.parse(pokeapi_base_url + 'pokemon/' + pokemon_id.to_s))

    create_pokemon(JSON.parse(result))
  end

  puts "All Pokemons were created!"
end

get_pokemons()
get_evolution_chains()
