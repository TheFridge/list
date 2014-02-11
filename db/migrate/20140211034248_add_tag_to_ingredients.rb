class AddTagToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :tag, :string
  end
end
