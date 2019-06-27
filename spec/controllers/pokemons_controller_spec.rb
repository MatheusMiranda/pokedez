require 'rails_helper'

describe Api::V1::PokemonsController do

  describe "GET #index - get all pokemons", type: :request do
    let!(:pokemons) { create_list(:pokemon, 20)}

    before do
      get "/api/v1/pokemons"
    end

    it 'returns all quotes' do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it "returns pokemons with right attributes" do
      json_response = JSON.parse(response.body)
      json_response.each do |pokemon_hash|
        expect(pokemon_hash.keys).to match_array(["id", "name", "types", "photo"])
      end
    end
  end

  describe "GET #show - get pokemon by id", type: :request do
    let!(:pokemon) { create(:pokemon, name: "jorel", types: ["bug", "poison"]) }

    before do
      get "/api/v1/pokemons/#{pokemon.id}"
    end

    it 'returns all quotes' do
      expect(JSON.parse(response.body).size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it "returns a pokemon with right attributes" do
      pokemon_hash = JSON.parse(response.body)
      expect(pokemon_hash.keys).to match_array(["id", "name", "types", "photo", "evolutions"])
    end

    it 'returns the pokemon name' do
      expect(JSON.parse(response.body)['name']).to eq('jorel')
    end

    it 'returns the pokemon types' do
      expect(JSON.parse(response.body)['types']).to eq(["bug", "poison"])
    end
  end

end
