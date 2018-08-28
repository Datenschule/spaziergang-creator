FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'testtesttest'
  end
end
