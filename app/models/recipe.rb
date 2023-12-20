class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, uniqueness: { scope: :user_id, message: 'You have already created a recipe with this name!' }
end
