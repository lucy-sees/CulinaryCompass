class AddPriceToRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :recipe_foods, :price, :decimal
  end
end
