FactoryBot.define do
  factory :recipe_food do
    quantity { 1 }
    price { 1.5 }
    measurement_unit { 'cup' }
    association :food
    association :recipe
  end
end
