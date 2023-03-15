class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  validates :name, presence: true
  validates :description, presence: true
  def total_price
    self.foods.sum { |food| food.price * food.quantity }
  end

  def foods_count
    self.foods.count
  end
end
