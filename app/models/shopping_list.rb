class ShoppingList < ActiveRecord::Base
  has_many :list_ingredients
  has_many :ingredients, through: :list_ingredients
  has_many :recipes_shopping_list
  has_many :recipes, through: :recipes_shopping_list

  validates_presence_of :user_id
end
