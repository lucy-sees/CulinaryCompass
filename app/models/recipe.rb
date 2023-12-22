class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :ingredients

  validates :name, uniqueness: { scope: :user_id, message: 'You have already created a recipe with this name!' }
  validates :name, :preparation_time, :cooking_time, :description, :user_id, presence: true
  validates :public, inclusion: { in: [true, false] }
end
