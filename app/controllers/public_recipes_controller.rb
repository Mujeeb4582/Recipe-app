class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user).includes(:foods).where(public: true)
  end
end
