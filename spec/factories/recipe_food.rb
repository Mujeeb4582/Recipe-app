FactoryBot.define do
  factory :recipe_food do
    id { Faker::Number.number(digits: 5) }
    quantity { Faker::Number.number(digits: 4) }
    recipe
    food
  end
end
