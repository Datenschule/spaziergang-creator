FactoryBot.define do
  factory :user do
    username { Faker::Crypto.md5 }
    email { Faker::Internet.email }
    password 'testtesttest'
  end
end
