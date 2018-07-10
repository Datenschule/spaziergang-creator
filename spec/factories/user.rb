FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'testtest'
  end
end
