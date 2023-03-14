class RecipesController < ApplicationController
  # load_and_authorize_resource param_method: :recipe_params, only: %i[create]
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    return render file: "#{Rails.root}/public/404.html", status: 404 unless @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    return render file: "#{Rails.root}/public/404.html", status: 404 unless @recipe
    # if @recipe.destroy
    #   redirect_to recipes_path
    # else
    #   redirect_back fallback_location: recipes_path
    # end
    if @recipe.destroy
      render json: { message: 'Recipe deleted' }, status: :ok
    else
      render json: { message: 'Recipe not deleted' }, status: :bad_request
    end
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end
end
