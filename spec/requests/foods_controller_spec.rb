require 'rails_helper'
require_relative '../support/controller_auth'

RSpec.describe FoodsController, type: :controller do
  extend ControllerAuth
  describe 'Testing routes' do
    login_user
    let(:user) { controller.current_user }
    let(:food) { FactoryBot.create(:food, user:) }
    describe 'when user is logged in' do
      it 'should return a 200 response' do
        get 'index', params: { user_id: user.id }
        expect(response).to have_http_status(200)
      end

      it 'should have text: "Foods"' do
        get 'index', params: { user_id: user.id }
        expect(response.body).to include('Foods List')
      end

      describe 'POST #create' do
        context 'when valid params are passed' do
          let(:user) { controller.current_user }
          let(:valid_params) do
            {
              food: {
                name: 'Spaghetti',
                measurement_unit: 'kg',
                price: 10,
                quantity: 2
              },
              user_id: user.id
            }
          end

          it 'creates a new food' do
            expect do
              post :create, params: valid_params
            end.to change(Food, :count).by(1)
          end

          it 'redirects to the user foods page' do
            post :create, params: valid_params
            expect(response).to redirect_to(user_foods_path(user))
          end

          it 'sets a flash message' do
            post :create, params: valid_params
            expect(flash[:success]).to eq('Food successfully added!')
          end
        end

        context 'when invalid params are passed' do
          let(:user) { FactoryBot.create(:user) }
          let(:invalid_params) do
            {
              food: {
                name: '',
                measurement_unit: 'kg',
                price: -10,
                quantity: -2
              },
              user_id: user.id
            }
          end

          it 'does not create a new food' do
            expect do
              post :create, params: invalid_params
            end.not_to change(Food, :count)
          end

          it 'sets a flash message' do
            post :create, params: invalid_params
            expect(flash[:error]).to eq('Food creation failed!')
          end
        end
      end

      describe '#destroy' do
        context 'when food exists' do
          before { delete :destroy, params: { user_id: user.id, id: food.id } }

          it 'deletes the food' do
            expect(Recipe.exists?(food.id)).to be_falsey
          end

          it 'redirects to the previous page' do
            expect(response).to redirect_to(user_foods_path(user))
          end

          it 'sets a flash notice' do
            expect(flash[:success]).to eq('Food deleted successfully!')
          end
        end

        context 'when food does not exist' do
          before { delete :destroy, params: { user_id: user.id, id: 'invalid_id' } }
        end

        context 'when food cannot be deleted' do
          before do
            allow(Food).to receive(:find_by).and_return(food)
            allow(food).to receive(:destroy).and_return(false)
            delete :destroy, params: { user_id: user.id, id: food.id }
          end

          it 'redirects to the previous page' do
            expect(response).to redirect_to(user_foods_path(user))
          end

          it 'does not delete the food' do
            expect(food.destroyed?).to be_falsey
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
      end
    end
  end
end
