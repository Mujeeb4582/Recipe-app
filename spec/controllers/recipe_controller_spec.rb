require 'rails_helper'
require_relative '../support/controller_auth'

RSpec.describe RecipesController, type: :controller do
  extend ControllerAuth
  describe 'Testing routes' do
    login_user
    let(:user) { controller.current_user }
    let(:recipe) { FactoryBot.create(:recipe, user:) }
    describe 'when user is logged in' do
      it 'should return a 200 response' do
        get 'index', params: { user_id: user.id }
        expect(response).to have_http_status(200)
      end

      it 'should have text: "Recipes"' do
        get 'index', params: { user_id: user.id }
        expect(response.body).to include('Recipes')
      end

      describe 'POST #create' do
        context 'when valid params are passed' do
          let(:user) { controller.current_user }
          let(:valid_params) do
            {
              recipe: {
                name: 'Spaghetti',
                description: 'A classic Italian dish',
                instructions: 'Cook the spaghetti according to package instructions. Heat the sauce in a separate pan..'
              },
              user_id: user.id
            }
          end

          it 'creates a new recipe' do
            expect do
              post :create, params: valid_params
            end.to change(Recipe, :count).by(1)
          end

          it 'redirects to the user recipes page' do
            post :create, params: valid_params
            expect(response).to redirect_to("/users/#{user.id}/recipes")
          end

          it 'sets a flash message' do
            post :create, params: valid_params
            expect(flash[:notice]).to eq('Recipe created')
          end
        end

        context 'when invalid params are passed' do
          let(:user) { FactoryBot.create(:user) }
          let(:invalid_params) do
            {
              recipe: {
                name: '',
                description: 'A classic Italian dish',
                instructions: 'Cook the spaghetti according to package instructions. Heat the sauce in a separate pan..'
              },
              user_id: user.id
            }
          end

          it 'does not create a new recipe' do
            expect do
              post :create, params: invalid_params
            end.not_to change(Recipe, :count)
          end

          it 'sets a flash message' do
            post :create, params: invalid_params
            expect(flash[:alert]).to eq('Recipe not created')
          end
        end
      end

      describe '#destroy' do
        context 'when recipe exists' do
          before { delete :destroy, params: { user_id: user.id, id: recipe.id } }

          it 'deletes the recipe' do
            expect(Recipe.exists?(recipe.id)).to be_falsey
          end

          it 'redirects to the previous page' do
            expect(response).to redirect_to(root_path)
          end

          it 'sets a flash notice' do
            expect(flash[:notice]).to eq('Recipe Deleted')
          end
        end

        context 'when recipe does not exist' do
          before { delete :destroy, params: { user_id: user.id, id: 'invalid_id' } }
        end

        context 'when recipe cannot be deleted' do
          before do
            allow(Recipe).to receive(:find_by).and_return(recipe)
            allow(recipe).to receive(:destroy).and_return(false)
            delete :destroy, params: { user_id: user.id, id: recipe.id }
          end

          it 'redirects to the previous page' do
            expect(response).to redirect_to(root_path)
          end

          it 'sets a flash alert' do
            expect(flash[:alert]).to eq('Recipe not deleted')
          end
        end
      end

      describe '#show' do
        context 'when recipe exists' do
          it 'should have a 200 status code' do
            get :show, params: { user_id: user.id, id: recipe.id }
            expect(response).to have_http_status(200)
          end
        end

        context 'when recipe does not exist' do
          it 'should render 404 page' do
            get :show, params: { user_id: user.id, id: -1 }
            expect(response).to have_http_status(404)
          end
        end
      end

      describe 'GET #new' do
        context 'when user is logged in' do
          it 'have http 200' do
            get :new, params: { user_id: user.id }
            expect(response).to have_http_status(200)
          end
        end

        context 'when user is not logged in or no user' do
          it 'returns a 404 error' do
            get :new, params: { user_id: -1 }
            expect(response).to have_http_status(404)
          end
        end
      end
    end
  end
end
