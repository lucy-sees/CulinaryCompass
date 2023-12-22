FactoryBot.define do
  factory :food do
    name { 'MyString' }
    measurement_unit { 'cup' }
    price { 1.5 }
    quantity { 1 }
    association :user
  end
end
