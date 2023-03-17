FactoryBot.define do
  factory :recipe_food do
    quantity { Faker::Number.number(digits: 4) }
    recipe
    food
  end
end
