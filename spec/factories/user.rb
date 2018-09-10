FactoryBot.define do
  factory :user do
    username { Faker::Seinfeld.character.split(' ').first }
    email { Faker::Internet.email }
    password 'testtesttest'
  end
end
