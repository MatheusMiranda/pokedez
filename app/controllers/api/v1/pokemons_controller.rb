class Api::V1::PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
  include ActionController::MimeResponds

  # GET /api/v1/pokemons
  def index
    pokemons = Pokemon.all.map{ |pokemon| pokemon.as_json }

    render json: pokemons
  end

  #GET /api/v1/pokemons/:pokemon_id
  def show
    render json: {
      id: @pokemon.id, name: @pokemon.name,
      types: @pokemon.types, evolutions: get_evolutions,
      photo: {
        url: @pokemon.photo.url,
        name: @pokemon.photo.original_filename,
        id: @pokemon.id
      }
    }
  end

  # POST /api/v1/pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render json: @pokemon, status: 200
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemons/1
  def update
    if @pokemon.update(pokemon_params)
      render json: @pokemon
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
  end

  private
  def get_evolutions
    evolutions = []
    first_evolutions = []
    second_evolutions = []

    @pokemon.evolutions.each do |evolution|
      pokemon = Pokemon.find_by("name": evolution)
      if pokemon != nil
        first_evolutions << pokemon
      end
    end

    first_evolutions.each do |first_evolution|
      first_evolution.evolutions.each do |evolution|
        pokemon = Pokemon.find_by("name": evolution)
        if pokemon != nil
          second_evolutions << pokemon
        end
      end
    end

    evolutions << first_evolutions
    evolutions << second_evolutions
    evolutions
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :photo, types: [], evolutions: [])
  end
end
