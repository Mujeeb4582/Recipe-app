class RecipesController < ApplicationController
  # load_and_authorize_resource param_method: :recipe_params, only: %i[create]
  def index
    @user = User.find_by(id: params[:user_id])
    return render file: "#{Rails.root}/public/404.html", status: 404 unless @user

    @recipes = @user.recipes
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    return render file: "#{Rails.root}/public/404.html", status: 404 unless @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to user_recipe_path(@user, @recipe)
      flash[:notice] = 'Recipe created'
    else
      render :new
      flash[:alert] = 'Recipe not created'
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    return render file: "#{Rails.root}/public/404.html", status: 404 unless @recipe

    if @recipe.destroy
      render json: { message: 'Recipe deleted' }, status: :ok
    else
      render json: { message: 'Recipe not deleted' }, status: :bad_request
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
