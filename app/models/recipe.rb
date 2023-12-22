class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, uniqueness: { scope: :user_id, message: 'You have already created a recipe with this name!' }
  validates :name, :preparation_time, :cooking_time, :description, :public, :user_id, presence: true
end
