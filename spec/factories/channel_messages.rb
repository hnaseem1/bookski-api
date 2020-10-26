FactoryBot.define do
  factory :channel_message do
    association :channel
    association :user
    message { Faker::Lorem.word }
  end
end