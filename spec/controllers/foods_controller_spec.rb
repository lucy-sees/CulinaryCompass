require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { create(:user) }
  let(:food) { create(:food, user:) }
  let(:valid_attributes) { { name: 'Apple', measurement_unit: 'kg', price: 1.5, quantity: 10 } }
  let(:invalid_attributes) { { name: '', measurement_unit: '', price: nil, quantity: nil } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: food.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: food.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Food' do
        expect do
          post :create, params: { food: valid_attributes }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the foods list' do
        post :create, params: { food: valid_attributes }
        expect(response).to redirect_to(foods_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Food' do
        expect do
          post :create, params: { food: invalid_attributes }
        end.to change(Food, :count).by(0)
      end

      it "renders 'new'" do
        post :create, params: { food: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'Orange' } }

      it 'updates the requested food' do
        put :update, params: { id: food.to_param, food: new_attributes }
        food.reload
        expect(food.name).to eq('Orange')
      end

      it 'redirects to the food' do
        put :update, params: { id: food.to_param, food: valid_attributes }
        food.reload
        expect(response).to redirect_to(food)
      end
    end

    context 'with invalid parameters' do
      it "renders 'edit'" do
        put :update, params: { id: food.to_param, food: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:food) { create(:food, user:) }

    before do
      sign_in user
    end

    it 'deletes the requested food' do
      delete :destroy, params: { id: food.to_param }
      expect(Food.count).to eq(0)
    end

    it 'redirects to the foods list' do
      delete :destroy, params: { id: food.to_param }
      expect(response).to redirect_to(foods_url)
    end
  end
end
