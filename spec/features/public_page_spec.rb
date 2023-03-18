require 'rails_helper'

describe '/ or /public_recipes', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'guest can see but not view a page' do
    recipe = FactoryBot.create(:recipe, public: true)
    recipe2 = FactoryBot.create(:recipe, public: false)

    visit '/'
    expect(page).to have_text('Recipes')
    # create a recipe
    number_of_public_recipes = [recipe, recipe2].select(&:public).count
    expect(all('li').count).to eq(number_of_public_recipes)

    page.first('.description').click
    expect(page).to have_text('You need to sign in or sign up before continuing.')
  end

  scenario 'user can see and view a page' do
    user.confirm # Confirm the user's email address
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
    recipe = FactoryBot.create(:recipe, public: true)
    recipe2 = FactoryBot.create(:recipe, public: false)

    visit '/'
    expect(page).to have_text('Recipes')
    # create a recipe
    number_of_public_recipes = [recipe, recipe2].select(&:public).count
    expect(all('li').count).to eq(number_of_public_recipes)

    page.first('.description').click
    expect(page).to have_text(recipe.name)
  end
end
