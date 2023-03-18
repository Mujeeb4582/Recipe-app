class Food < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, foreign_key: 'food_id', dependent: :destroy
  has_many :recipes, through: :recipe_foods, foreign_key: 'recipe_id'

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, decimal: true, precision: 8, scale: 2 }
  validates :quantity, presence: true, numericality: { greater_than: 0, decimal: true, precision: 8, scale: 2 }
  validates :measurement_unit, presence: true
end
