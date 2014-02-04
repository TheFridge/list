class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :source_url
      t.string :servings
      t.timestamps
    end
  end
end
