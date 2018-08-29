FactoryBot.define do
  factory :walk do
    user
    name { Faker::HeyArnold.character }
    location { Faker::HeyArnold.location }
    description { Faker::HeyArnold.quote }
    public = false
  end
end
