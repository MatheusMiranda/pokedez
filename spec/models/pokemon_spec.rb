require "rails_helper"

describe Pokemon do
  let(:pokemon) { create(:pokemon) }

  it "is valid" do
    expect(pokemon).to be_valid
  end

  it "is not valid without a name" do
    pokemon.name = nil
    expect(pokemon).not_to be_valid
  end

  it "is not valid without a photo" do
    pokemon.photo = nil
    expect(pokemon).not_to be_valid
  end

  it "is not valid without a photo" do
    pokemon.photo = nil
    expect(pokemon).not_to be_valid
  end

  it "is not valid with the same name" do
    expect(create(:pokemon, name: "Same name")).to be_valid
    expect(build(:pokemon, name: "Same name")).not_to be_valid
  end
end
