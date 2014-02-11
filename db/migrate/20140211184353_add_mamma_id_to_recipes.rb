class AddMammaIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :mamma_id, :integer
  end
end
