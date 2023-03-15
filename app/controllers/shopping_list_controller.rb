class ShoppingListController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id)
    @general_shopping_list,@total = current_user.general_shopping_list(@recipe_foods)
  end
end
