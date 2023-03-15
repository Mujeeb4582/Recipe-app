class RecipesController < ApplicationController
  # load_and_authorize_resource param_method: :recipe_params, only: %i[create]
  def index
    # There might be some profile seeing links here so I used params instead of current_usr
    @user = User.find_by(id: params[:user_id])
    return render file: "#{Rails.root}/public/404.html", status: 404 unless @user

    @recipes = @user.recipes
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    return render file: "#{Rails.root}/public/404.html", status: 404 unless @recipe
  end

  def new
    return render file: "#{Rails.root}/public/404.html", status: 404 unless current_user.id.to_s == params[:user_id]

    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to "/users/#{current_user.id}/recipes"
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
      flash[:notice] = "Recipe Deleted"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Recipe not deleted'

    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
