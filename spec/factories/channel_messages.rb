FactoryBot.define do
  factory :channel_message do
    message { Faker::Lorem.word }
    # user_id nil
    # channel_id nil
  end
end