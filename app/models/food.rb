class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :food_categories
  has_many :categories, through: :food_categories

  validates :name, :measurement_unit, :price, :quantity, presence: true
end
