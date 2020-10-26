FactoryBot.define do
  factory :channel do
    name { Faker::StarWars.character }
  end
end