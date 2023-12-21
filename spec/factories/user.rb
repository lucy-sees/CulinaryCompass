FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    name { 'Victor' }
    password { "password" }
    # other attributes...
  end
end
