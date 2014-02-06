class AddRawIngredientNametoListIngredients < ActiveRecord::Migration
  def change
    add_column :list_ingredients, :raw_name, :string
  end
end
