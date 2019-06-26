FactoryBot.define do
  factory :pokemon do
    sequence(:name) { |n| "#{Faker::Lorem.word} #{n}" }
    types {["grass", "poison"]}
    evolutions {["charmilion", "raichu"]}
    sequence(:description)   { |n| "Awesome description for Pokemon #{n}" }
    #sprite { File.new(Rails.root.join('spec', 'fixtures', 'filename.png')) }

    before :create do |pokemon|
      pokemon.photo_file_name = "photo.jpg"
      pokemon.photo_content_type = "image/jpeg"
      pokemon.photo_file_size = 2588
      pokemon.photo_updated_at = Time.zone.now
    end
  end
end
