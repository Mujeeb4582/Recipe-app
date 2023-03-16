require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.build(:food, user:) }
  let(:food2) { FactoryBot.build(:food, user:) }
  let(:recipe) { FactoryBot.build(:recipe, user:) }
  let(:recipe_food) { FactoryBot.build(:recipe_food, food:, recipe:) }
  let(:recipe_food2) { FactoryBot.build(:recipe_food, food: food2, recipe:) }
  before(:each) do
    recipe.foods << food
    recipe.foods << food2
  end

  it 'has name' do
    expect(recipe.name).to be_present
  end

  # it 'has description, preparation_time, cooking_time'

  it 'has description' do
    expect(recipe.description).to be_present
  end

  it 'has preparation_time' do
    expect(recipe.preparation_time).to be_present
  end

  it 'has cooking_time' do
    expect(recipe.cooking_time).to be_present
  end

  it 'methods total_price works' do
    expect(recipe.total_price).to eq((food.price * food.quantity) + (food2.price * food2.quantity))
  end

  it 'methods foods_count works' do
    expect(recipe.foods_count).to eq(2)
  end
end
