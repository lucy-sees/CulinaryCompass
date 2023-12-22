class AddValueToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :value, :decimal
  end
end
