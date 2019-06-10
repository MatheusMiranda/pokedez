class Api::V1::PokemonsController < ApplicationController

  # GET /api/v1/pokemons
  def index
    pokemons = Pokemon.all.map{ |pokemon|
      {
        id: pokemon.id, name: pokemon.name
      }
    }
    render json: pokemons
  end

end
