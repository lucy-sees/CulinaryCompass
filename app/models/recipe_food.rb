class RecipeFood < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  validates :food_id,
            uniqueness: { scope: %i[recipe_id quantity], message: 'already exists with this recipe and quantity!' }
end
