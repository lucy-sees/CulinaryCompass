require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  subject do
    @user = User.create(name: 'Roxie')
    @food = Food.create(name: 'Pilau', measurement_unit: 'grams', price: 605, quantity: 5, user_id: @user.id)
    @recipe = Recipe.create(name: 'Pilau recipe', preparation_time: 30, cooking_time: 60, description: 'You know how',
                            public: true, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 30, food_id: @food.id, recipe_id: @recipe.id)
  end

  before { subject.save }

  it 'Quantity should be present' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it 'Quantity should have valid value' do
    expect(subject.quantity).to eql 30
  end

  it 'Quantity should be a integer' do
    expect(subject.quantity).to be_a(Integer)
  end
end
