FactoryBot.define do
  factory :station do
    name { Faker::Friends.character }
    description { Faker::Friends.quote }
    lon { Faker::Number.decimal(2, 5) }
    lat { Faker::Number.decimal(2, 5) }
  end
end
