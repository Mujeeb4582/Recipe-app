require 'rails_helper'

RSpec.feature 'FoodIndices', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }

  before do
    user.confirm # Confirm the user's email address
    login_as(user) # sign in the user
  end

  describe 'Index page' do
    it 'can see the Food List text on the page.' do
      visit user_foods_path(user)
      expect(page).to have_content('Food List')
    end
    it "can click on the 'Add Food' button" do
      visit user_foods_path(user)
      click_button 'Add Food'
      expect(page).to have_current_path(new_user_food_path(user))
    end
  end

  describe 'New food page' do
    it 'can add a new food' do
      visit new_user_food_path(user)

      fill_in 'Food name', with: 'Pizza'
      select 'kg', from: 'Measurement unit'
      fill_in 'Unit price', with: 12
      fill_in 'Quantity', with: 2

      click_button 'Add Food'

      expect(page).to have_content('Food successfully added!')
    end
  end
end
