FactoryBot.define do
  factory :recipe do
    name { 'Test Recipe' }
    description { 'This is a test recipe' }
    preparation_time { 30 }
    cooking_time { 45 }
    public { true }
    association :user
    # other attributes...
  end
end
