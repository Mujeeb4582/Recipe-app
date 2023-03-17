require 'rails_helper'

describe '/users/:user_id/recipes', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe) }
  let(:recipe2) { FactoryBot.create(:recipe) }

  before do
    user.confirm # Confirm the user's email address
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'user can create a recipe, view the recipes, delete the recipes, should see invidula page' do
    visit new_user_recipe_path(user)
    fill_in 'Name', with: recipe.name
    fill_in 'Preparation time', with: recipe.preparation_time
    fill_in 'Cooking time', with: recipe.cooking_time
    fill_in 'Description', with: recipe.description
    check 'Public'
    click_button 'Create Recipe'
    expect(page).to have_text('Recipe created')

    recipe = Recipe.last

    expect(page).to have_text(recipe.name)
    expect(page).to have_text(recipe.description)

    # new recipe button

    click_link 'Add Recipe'
    expect(current_path).to eq(new_user_recipe_path(user))

    fill_in 'Name', with: recipe2.name
    fill_in 'Preparation time', with: recipe2.preparation_time
    fill_in 'Cooking time', with: recipe2.cooking_time
    fill_in 'Description', with: recipe2.description
    check 'Public'
    click_button 'Create Recipe'

    expect(page).to have_text('Recipe created')

    expect(all('li').count).to eq(2)

    # delete the recipe

    page.first(:button, 'Remove').click

    expect(page).to have_text('Recipe Deleted')

    expect(all('li').count).to eq(1)

    # show individual recipe
    page.first('.description').click
    expect(page).to have_text(recipe2.name)
  end
end
