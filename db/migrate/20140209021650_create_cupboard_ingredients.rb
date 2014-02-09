class CreateCupboardIngredients < ActiveRecord::Migration
  def change
    create_table :cupboard_ingredients do |t|
      t.integer :cupboard_id
      t.integer :ingredient_id
      t.integer :quantity
      t.string :measurement

      t.timestamps
    end
  end
end
