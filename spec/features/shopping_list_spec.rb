require 'rails_helper'

describe '/users/:user_id/recipes/:recipe_id/general_shopping_list', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    user.confirm # Confirm the user's email address
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'we can see the shopping list, and their data' do
    recipe = FactoryBot.create(:recipe, user:)
    food = FactoryBot.create(:food, user:)
    food2 = FactoryBot.create(:food, user:)
    recipe_food = FactoryBot.create(:recipe_food, recipe:, food:)
    recipe_food2 = FactoryBot.create(:recipe_food, recipe:, food: food2)
    visit "/users/#{user.id}/recipes/#{recipe.id}/general_shopping_list"
    expect(page).to have_text(food.name)
    total_foods_to_buy, total_price = user.general_shopping_list([recipe_food, recipe_food2])
    expect(page).to have_text("Amount of items to buy: #{total_foods_to_buy.length}")
    expect(page).to have_text("Total price: #{total_price}")
  end
end
