require 'rails_helper'
require_relative '../support/controller_auth'

RSpec.describe ShoppingListController, type: :controller do
  extend ControllerAuth
  describe 'GET #index' do
    login_user
    # logic => make user => make recipe from that user => make food from that user => test generate shopping list
    let(:user) { FactoryBot.create(:user) }
    before { user.save }

    let(:recipe) { FactoryBot.create(:recipe, user:) }
    before { recipe.save }

    context 'when user is logged in' do
      it 'should return a 200 response to general_shopping_list route' do
        get 'index', params: { user_id: user.id, recipe_id: recipe.id }
        expect(response).to have_http_status(200)
      end

      it 'should have test: "Shopping List"' do
        get 'index', params: { user_id: user.id, recipe_id: recipe.id }
        expect(response.body).to include('Shopping List')
      end
    end
  end
end
