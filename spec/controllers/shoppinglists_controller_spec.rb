require 'rails_helper'

RSpec.describe "Shoppinglists", type: :request do
  let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'password') }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    it "returns http success" do
      get shoppinglists_path
      expect(response).to have_http_status(:success)
    end

    it "displays the correct count and sum of food prices" do
      food1 = Food.create!(name: 'Apple', price: 1.5, measurement_unit: 'kg', quantity: 1, user: user)
      food2 = Food.create!(name: 'Banana', price: 2.0, measurement_unit: 'kg', quantity: 1, user: user)

      get shoppinglists_path

      expect(response.body).to include('2') # count of foods
      expect(response.body).to include('3.5') # sum of food prices
    end
  end
end
