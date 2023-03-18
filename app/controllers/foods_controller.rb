class FoodsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @foods = Food.find_by(user_id: params[:id])
  end

  def show
    @user = User.find(params[:user_id])
    @food = Food.find_by(id: params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      flash[:success] = 'Food successfully added!'
      redirect_to user_foods_path(current_user)
    else
      flash.now[:error] = 'Food creation failed!'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.user_id == current_user.id && @food.destroy
      flash[:success] = 'Food deleted successfully!'
    else
      flash[:error] = 'Food deletion failed!'
    end
    redirect_to user_foods_path(current_user)
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
