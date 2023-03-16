FactoryBot.define do
  factory :recipe do
    id { Faker::Number.number(digits: 5) }
    name { Faker::Food.dish }
    description { Faker::Food.description }
    preparation_time { Faker::Number.between(from: 1, to: 60) }
    cooking_time { Faker::Number.between(from: 1, to: 60) }
    user
  end
end
