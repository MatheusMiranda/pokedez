class Api::V1::PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
  include ActionController::MimeResponds

  # GET /api/v1/pokemons
  def index
    filter_param = params[:filter] || ""

    pokemons = Pokemon.all.select{
      |pokemon| pokemon.name.downcase.include? filter_param.downcase
    }.map{ |pokemon|
      {
        id: pokemon.id, name: pokemon.name, types: pokemon.types
      }
    }

    render json: pokemons
  end

  #GET /api/v1/pokemons/:pokemon_id
  def show
    render json: { id: @pokemon.id, name: @pokemon.name, types: @pokemon.types, evolutions: get_evolutions}
  end

  # POST /api/v1/pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)

    respond_to do |format|
      if @pokemon.save
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon }
      else
        format.html { render :new }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemons/1
  def update
    respond_to do |format|
      if @pokemon.update(pokemon_params)
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokemon }
      else
        format.html { render :edit }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
    respond_to do |format|
      format.html { redirect_to pokemons_url, notice: 'Pokemon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_evolutions
      evolutions = []

      first_evolutions = []
      second_evolutions = []

      @pokemon.evolutions.each do |evolution|
        evolution_pokemon = Pokemon.find_by("name": evolution)
        if evolution_pokemon != nil
          first_evolutions << evolution_pokemon
        end
      end

      first_evolutions.each do |evol|
        evol.evolutions.each do |evolution|
          evolution_pokemon = Pokemon.find_by("name": evolution)
          if evolution_pokemon!= nil
            second_evolutions << evolution_pokemon
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
      params.require(:pokemon).permit(:name, :sprite, :photo, types: [], evolutions: [])
    end
end
