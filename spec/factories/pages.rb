FactoryBot.define do
  factory :page do
    name { Faker::Zelda.game }
    variant { Page::VARIANTS.sample }
    link { Faker::Internet.url }
    question { Faker::Seinfeld.quote }
    answers { 3.times.map { |x|
                x == 0 ? "-* #{Faker::Zelda.character}" : "- #{Faker::Zelda.location}"
              }.join("\r\n") }
    content { Faker::Seinfeld.quote }
    challenges { 2.times.map { |x|
                   x == 0 ? "-* #{Faker::Zelda.character}" : "- #{Faker::Zelda.location}"
                 }.join("\r\n") }
  end
end
