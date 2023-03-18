class ShoppingListController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id).includes(:food)
    @recipe_foods_with_names = @recipe_foods.map do |rf|
      { id: rf.id, quantity: rf.quantity, recipe_id: rf.recipe_id, food_id: rf.food_id, name: rf.food.name,
        price: rf.food.price }
    end
    @general_shopping_list, @total = current_user.general_shopping_list(@recipe_foods_with_names)
  end
end
