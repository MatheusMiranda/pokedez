class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :sprite
      t.string :evolutions, array: true, default: []
      t.string :types, array: true, default: []

      t.timestamps
    end
  end
end
