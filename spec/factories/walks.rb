FactoryBot.define do
  factory :walk do
    user
    name { Faker::Lorem.words(3) }
    location { Faker::HeyArnold.location }
    description { Faker::HeyArnold.quote }
    public = false
  end
end
