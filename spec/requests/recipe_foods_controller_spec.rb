require 'rails_helper'
require_relative '../support/controller_auth'

RSpec.describe RecipeFoodsController, type: :controller do
  extend ControllerAuth
  describe 'Testing routes' do
    login_user
    let(:user) { controller.current_user }
    let(:recipe) { FactoryBot.create(:recipe, user:) }
    let(:food) { FactoryBot.create(:food) }
    let(:recipe_food) { FactoryBot.create(:recipe_food, recipe:, food:) }

    describe 'when user is logged in' do
      it 'should return a 200 response' do
        get :new, params: { user_id: user.id, recipe_id: recipe.id }
        expect(response).to have_http_status(200)
      end

      it 'should have text: Add ingredient' do
        get :new, params: { user_id: user.id, recipe_id: recipe.id }
        expect(response.body).to include('Add ingredient')
      end

      describe 'POST #create' do
        let(:user) { controller.current_user }
        let(:valid_params) do
          {
            user_id: user.id,
            recipe_id: recipe.id,
            quantity: 2,
            food_id: food.id
          }
        end
        context 'when valid params are passed' do
          it 'creates a new recipe food' do
            expect do
              post :create, params: valid_params
            end.to change(RecipeFood, :count).by(1)
          end
        end

        it 'redirects to the recipe page' do
          post :create, params: valid_params

          expect(response).to redirect_to(user_recipe_url(recipe.user, recipe))
          expect(flash[:notice]).to eq('Ingredient has been added successfully!')
        end
      end
      describe 'PUT #update' do
        let(:user) { controller.current_user }
        let(:id) { recipe_food.id }
        let(:valid_params) do
          {
            user_id: user.id,
            recipe_id: recipe.id,
            quantity: 3,
            food_id: food.id,
            id:
          }
        end
        it 'updates the recipe food' do
          put :update, params: valid_params

          recipe_food.reload
          expect(recipe_food.quantity).to eq(3)
          expect(recipe_food.food).to eq(food)
        end

        it 'redirects to the recipe page' do
          put :update, params: valid_params

          expect(response).to redirect_to(user_recipe_url(recipe_food.recipe.user, recipe_food.recipe))
          expect(flash[:notice]).to eq('Recipe food updated Successfully!')
        end
      end

      describe 'DELETE #destroy' do
        let(:valid_params) do
          {
            user_id: user.id,
            recipe_id: recipe.id,
            id: recipe_food.id
          }
        end
        it 'deletes the recipe food' do
          recipe_food

          expect do
            delete :destroy, params: valid_params
          end.to change(RecipeFood, :count).by(-1)
        end

        it 'redirects to the recipe page' do
          delete :destroy, params: valid_params

          expect(response).to redirect_to(user_recipe_url(recipe.user, recipe))
          expect(flash[:notice]).to eq('Ingredient deleted!')
        end
      end
    end
  end
end
