class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :foods, foreign_key: :user_id, dependent: :destroy
  has_many :recipes, foreign_key: :user_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true

  def general_shopping_list(recipe_foods)
    all_foods = foods
    missing_foods = all_foods.reject { |food| recipe_foods.any? { |hash| hash[:name] == food.name } }
    total = missing_foods.sum { |food| food[:price] * food[:quantity] }
    [missing_foods, total]
  end

  def admin?
    role == 'admin'
  end
end
