FactoryBot.define do
  factory :ingredient do
    name { 'MyString' }
    quantity { 1 }
    recipe { nil }
  end
end
