FactoryBot.define do
  factory :walk do
    name { Faker::Lorem.words(3) }
    location { Faker::HeyArnold.location }
    description { Faker::HeyArnold.quote }
  end
end
