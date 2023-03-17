class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :foods, foreign_key: :user_id, dependent: :destroy
  has_many :recipes, foreign_key: :user_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true

  def general_shopping_list(recipe_foods)
    missing_foods = []
    all_foods = foods
    recipe_foods.each do |recipe_food|
      food = all_foods.select { |f| f.name.downcase == recipe_food[:name].downcase }.first
      food_in_shopping_list?(food, recipe_food, missing_foods)
    end
    total = missing_foods.sum { |food| food[:price] * food[:quantity] }
    return missing_foods, total
  end

  def food_in_shopping_list?(food, recipe_food, missing_foods)
    # p [food, recipe_food, missing_foods, "TES"]
    if food.nil?
      return missing_foods << {
        name: recipe_food[:name],
        quantity: recipe_food[:quantity],
        price: recipe_food[:price],
        test: false
      }
    elsif food.quantity < recipe_food[:quantity]
      return missing_foods << {
        name: food.name,
        quantity: (recipe_food[:quantity] - food.quantity),
        price: food.price,
        test: true
      }
    end
  end

  def admin?
    role == 'admin'
  end
end
