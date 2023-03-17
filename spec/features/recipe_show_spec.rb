require 'rails_helper'

RSpec.feature 'RecipeShows', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let!(:food) { FactoryBot.create(:food, user:) }

  before do
    user.confirm # Confirm the user's email address
    login_as(user) # sign in the user
  end

  describe 'Show page' do
    it 'can see the Food List text on the page.' do
      visit user_recipe_path(user, recipe)
      expect(page).to have_content('Recipe Name')
    end
    it "can click on the 'Add ingredient' button" do
      visit user_recipe_path(user, recipe)
      click_button 'Add ingredient'
      expect(page).to have_current_path(new_user_recipe_recipe_food_path(recipe.user, recipe))
    end
    it "can click on the 'Generate shopping list' button" do
      visit user_recipe_path(user, recipe)
      click_button 'Generate shopping list'
      expect(page).to have_current_path(user_recipe_general_shopping_list_path(recipe.user, recipe))
    end
  end

  describe 'New Ingredient page' do
    it 'can add a new Ingredient' do
      visit new_user_recipe_recipe_food_path(recipe.user, recipe)
      select food.name, from: 'Foods'
      fill_in 'Quantity', with: 2

      click_button 'Add Food'

      expect(page).to have_content('Ingredient has been added successfully!')
    end
  end
end
