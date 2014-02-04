class RecipesShoppingList < ActiveRecord::Base
  belongs_to :shopping_list
  belongs_to :recipe
end
