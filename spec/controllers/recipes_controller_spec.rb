require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:recipe) do
    Recipe.create!(name: 'Test Recipe', preparation_time: 30, cooking_time: 45, description: 'Test Description',
                   public: true, user:)
  end

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: recipe.id }
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
      get :edit, params: { id: recipe.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Recipe' do
        expect do
          post :create,
               params: { recipe: { name: 'New Recipe', preparation_time: 30, cooking_time: 45, description: 'New Description',
                                   public: true, user_id: user.id } }
        end.to change(Recipe, :count).by(1)
      end

      it 'redirects to the created recipe' do
        post :create,
             params: { recipe: { name: 'New Recipe', preparation_time: 30, cooking_time: 45, description: 'New Description',
                                 public: true, user_id: user.id } }
        expect(response).to redirect_to(Recipe.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Recipe' do
        expect do
          post :create,
               params: { recipe: { name: '', preparation_time: '', cooking_time: '', description: '', public: '',
                                   user_id: '' } }
        end.to change(Recipe, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post :create,
             params: { recipe: { name: '', preparation_time: '', cooking_time: '', description: '', public: '',
                                 user_id: '' } }
        expect(response).to be_successful
      end
    end
  end
  describe 'PUT #update' do
    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        put :update, params: { id: recipe.id, recipe: { name: '' } }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested recipe' do
      recipe.save
      expect do
        delete :destroy, params: { id: recipe.id }
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes list' do
      recipe.save
      delete :destroy, params: { id: recipe.id }
      expect(response).to redirect_to(recipes_url)
    end
  end
end
