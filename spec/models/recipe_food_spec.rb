require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, food:, recipe:) }

  it 'has quantity' do
    expect(recipe_food.quantity).to be_present
  end

  it 'has food' do
    expect(recipe_food.food).to be_present
  end

  it 'has recipe' do
    expect(recipe_food.recipe).to be_present
  end
end
