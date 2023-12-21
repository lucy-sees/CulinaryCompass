class CreateFoodCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :food_categories do |t|
      t.references :food, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
