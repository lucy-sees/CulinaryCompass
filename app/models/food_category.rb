class FoodCategory < ApplicationRecord
  belongs_to :food
  belongs_to :category
end
