class AddMeasurementUnitToRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :recipe_foods, :measurement_unit, :string
  end
end
