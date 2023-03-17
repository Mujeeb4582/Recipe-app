require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, food:, recipe:) }

  it 'has name' do
    expect(user.name).to be_present
  end

  it 'method general_shopping_list works' do
    missing_foods, total = user.general_shopping_list([recipe_food])
    expect(missing_foods).to include(
      { name: food.name, quantity: (recipe_food.quantity - food.quantity), price: food.price, test: true }
    )
    expect(total).to eq(food.price * (recipe_food.quantity - food.quantity))
  end
end
