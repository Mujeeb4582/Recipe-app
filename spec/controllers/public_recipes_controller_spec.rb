require 'rails_helper'
require_relative '../support/controller_auth'

RSpec.describe PublicRecipesController, type: :controller do
  extend ControllerAuth
  describe 'GET #index' do
    login_user

    context 'when user is logged in' do
      it 'should return a 200 response' do
        get :index
        expect(response).to have_http_status(200)
      end

      it "should have text: 'Public Recipes'" do
        get :index
        expect(response.body).to include('public recipe')
      end
    end
  end
end
