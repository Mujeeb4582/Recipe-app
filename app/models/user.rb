class User < ApplicationRecord
  has_many :foods, foreign_key: :user_id, dependent: :destroy
  has_many :recipes, foreign_key: :user_id, dependent: :destroy

  validates :name, presence: true
end
