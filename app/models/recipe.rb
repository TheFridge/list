class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipes_shopping_list
  has_many :shopping_lists, through: :recipes_shopping_list
  validates_presence_of :name
end
