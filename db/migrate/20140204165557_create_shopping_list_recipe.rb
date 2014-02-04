class CreateShoppingListRecipe < ActiveRecord::Migration
  def change
    create_table :shopping_list_recipes do |t|
      create_join_table :shopping_lists, :recipes
    end
  end
end
