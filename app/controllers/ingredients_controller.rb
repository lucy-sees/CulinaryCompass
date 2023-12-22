class IngredientsController < ApplicationController
  before_action :set_recipe

  def new
    @ingredient = @recipe.ingredients.build
  end

  def show
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.find(params[:id])
  end

  def create
    @ingredient = @recipe.ingredients.build(ingredient_params)

    if @ingredient.save
      redirect_to @recipe, notice: 'Ingredient was successfully added.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.find(params[:id])
    if @ingredient.update(ingredient_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.find(params[:id])
    @ingredient.destroy
    redirect_to recipe_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :value)
  end
end
