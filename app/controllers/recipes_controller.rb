class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = current_user.recipes.includes(:recipe_foods)
  end

  # GET /public_recipe
  def public
    @recipes = Recipe.includes(:recipe_foods).where(public: true).order(created_at: :desc)
  end

  # GET /general_shopping list
  def general; end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  def edit; end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :ok }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @recipe.user == current_user
      @recipe.destroy!
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: 'Recipe was successfully deleted.') }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: 'You are not authorized to delete this recipe.') }
        format.json { render json: { error: 'Not Authorized' }, status: 403 }
      end
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      if @recipe.update(recipe_params)
        Rails.logger.debug @recipe.inspect
        redirect_to @recipe, notice: 'Recipe visibility was successfully updated.'
      else
        Rails.logger.debug @recipe.errors.full_messages
        redirect_to @recipe, alert: 'There was an error updating the recipe.'
      end
    else
      redirect_to @recipe, alert: 'You are not authorized to change this recipe.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
