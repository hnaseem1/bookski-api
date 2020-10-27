FactoryBot.define do
  factory :channel do
    name { Faker::Name.unique.name }
  end
end