require 'rails_helper'

describe '/general_shopping_list/:recipe_id', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    user.confirm # Confirm the user's email address
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  # let!(:food) { FactoryBot.create(:food, user:) }
  # let!(:food2) { FactoryBot.create(:food, user:) }

  scenario 'we can see the shopping list, and their data' do
    recipe = FactoryBot.create(:recipe, user:)
    food = FactoryBot.create(:food, user:)
    food2 = FactoryBot.create(:food, user:)
    FactoryBot.create(:recipe_food, recipe:, food:)
    FactoryBot.create(:recipe_food, recipe:, food: food2)
    visit "/general_shopping_list/#{recipe.id}"
    expect(page).to have_text(food.name)
    recipe_foods = RecipeFood.where(recipe_id: recipe.id).includes(:food)
    recipe_foods_with_names = recipe_foods.map do |rf|
      { id: rf.id, quantity: rf.quantity, recipe_id: rf.recipe_id, food_id: rf.food_id, name: rf.food.name }
    end
    total_foods_to_buy, total_price = user.general_shopping_list(recipe_foods_with_names)
    expect(page).to have_text("Amount of items to buy: #{total_foods_to_buy.length}")
    expect(page).to have_text("Total price: #{total_price}")
  end
end
