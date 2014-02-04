class CreateShoppingListRecipe < ActiveRecord::Migration
  def change
    create_join_table :shopping_lists, :recipes
  end
end
