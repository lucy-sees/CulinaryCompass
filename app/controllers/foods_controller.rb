class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]
  before_action :check_owner, only: %i[edit update destroy]

  def index
    @foods = current_user.foods.includes(:recipe_foods)
  end

  def show; end

  def new
    @food = Food.new
  end

  def edit; end

  def create
    @food = current_user.foods.build(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food was successfully created!' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_path, notice: 'Food was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private

  def set_food
    @food = Food.includes(:recipe_foods).find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def check_owner
    return if @food.user == current_user

    redirect_to foods_path, alert: 'You can only edit or delete your own foods.'
  end
end
