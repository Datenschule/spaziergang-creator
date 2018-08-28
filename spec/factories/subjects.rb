FactoryBot.define do
  factory :subject do
    name { Faker::Friends.character }
    description { Faker::Friends.quote }
  end
end
