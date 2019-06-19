class AddAttachmentPhotoToPokemons < ActiveRecord::Migration[5.1]
  def self.up
    change_table :pokemons do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :pokemons, :photo
  end
end
