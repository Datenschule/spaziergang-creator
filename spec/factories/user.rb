FactoryBot.define do
  factory :user do
    username { Faker::Cat.name }
    email { Faker::Internet.email }
    password 'testtesttest'
  end
end
