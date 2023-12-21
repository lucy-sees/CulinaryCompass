require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:recipe_food) { create(:recipe_food) }
  let(:valid_attributes) { { quantity: 2, food_id: create(:food).id, recipe_id: create(:recipe).id } }
  let(:invalid_attributes) { { quantity: nil, food_id: nil, recipe_id: nil } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: recipe_food.id }
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
      get :edit, params: { id: recipe_food.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new RecipeFood' do
        expect do
          post :create, params: { recipe_food: valid_attributes }
        end.to change(RecipeFood, :count).by(1)
      end

      it 'redirects to the created recipe_food' do
        post :create, params: { recipe_food: valid_attributes }
        expect(response).to redirect_to(RecipeFood.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new RecipeFood' do
        expect do
          post :create, params: { recipe_food: invalid_attributes }
        end.to change(RecipeFood, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post :create, params: { recipe_food: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { quantity: 3 } }

      it 'updates the requested recipe_food' do
        put :update, params: { id: recipe_food.id, recipe_food: new_attributes }
        recipe_food.reload
        expect(recipe_food.quantity).to eq(new_attributes[:quantity])
      end

      it 'redirects to the recipe_food' do
        put :update, params: { id: recipe_food.id, recipe_food: new_attributes }
        recipe_food.reload
        expect(response).to redirect_to(recipe_food)
      end
    end
    context 'with invalid parameters' do
      it 'does not update the requested recipe_food' do
        put :update, params: { id: recipe_food.id, recipe_food: invalid_attributes }
        recipe_food.reload
        expect(recipe_food.quantity).not_to eq(invalid_attributes[:quantity])
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        put :update, params: { id: recipe_food.id, recipe_food: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested recipe_food' do
      recipe_food = RecipeFood.create! valid_attributes
      expect do
        delete :destroy, params: { id: recipe_food.id }
      end.to change(RecipeFood, :count).by(-1)
    end

    it 'redirects to the recipe_foods list' do
      delete :destroy, params: { id: recipe_food.id }
      expect(response).to redirect_to(recipe_foods_url)
    end
  end
end
