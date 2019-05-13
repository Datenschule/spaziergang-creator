FactoryBot.define do
  PRIOS ||= (0..6).cycle
  factory :station do
    name { Faker::Friends.character }
    description { Faker::Friends.quote }
    lon { Faker::Number.decimal(2, 5) }
    lat { Faker::Number.decimal(2, 5) }
    priority { PRIOS.next }
    next nil
  end
end
