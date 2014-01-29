class CreateListIngredients < ActiveRecord::Migration
  def change
    create_table :list_ingredients do |t|
      t.integer :shopping_list_id
      t.integer :ingredient_id
      t.integer :quantity
      t.string :measurement
      t.timestamps
    end
  end
end
