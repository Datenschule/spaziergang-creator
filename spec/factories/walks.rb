FactoryBot.define do
  factory :walk do
    user
    name { Faker::Lebowski.character }
    location { Faker::HeyArnold.location }
    description { Faker::HeyArnold.quote }
    public = false
  end
end
