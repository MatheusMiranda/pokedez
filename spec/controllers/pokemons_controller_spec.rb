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
    let!(:pokemon) { create(:pokemon, name: "jorel", types: ["bug", "poison"],
                            photo_file_name: "jorel.jpg",
                            photo_content_type: "image/jpeg",
                            photo_file_size: 2588,
                            photo_updated_at: Time.zone.now
                            ) }

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



  #describe 'POST create' do
  #  before do
  #    @process = create(:legislation_process, debate_start_date: Date.current - 3.days, debate_end_date: Date.current + 2.days)
  #    @question = create(:legislation_question, process: @process, title: "Question 1")
  #    @user = create(:user, :level_two)
  #    @unverified_user = create(:user)
  #  end

  #  it 'creates an comment if the comments are open' do
  #    sign_in @user

  #    expect do
  #      xhr :post, :create, comment: {commentable_id: @question.id, commentable_type: "Legislation::Question", body: "a comment"}
  #    end.to change { @question.reload.comments_count }.by(1)
  #  end

  #  it 'does not create a comment if the comments are closed' do
  #    sign_in @user
  #    @process.update_attribute(:debate_end_date, Date.current - 1.day)

  #    expect do
  #      xhr :post, :create, comment: {commentable_id: @question.id, commentable_type: "Legislation::Question", body: "a comment"}
  #    end.not_to change { @question.reload.comments_count }
  #  end

  #  it 'does not create a comment for unverified users when the commentable requires it' do
  #    sign_in @unverified_user

  #    expect do
  #      xhr :post, :create, comment: {commentable_id: @question.id, commentable_type: "Legislation::Question", body: "a comment"}
  #    end.not_to change { @question.reload.comments_count }
  #  end
  #end
end
