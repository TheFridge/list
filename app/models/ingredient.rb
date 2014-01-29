class Ingredient < ActiveRecord::Base
  has_many :list_ingredients
  has_many :shopping_lists, through: :list_ingredients
  validates_presence_of :name
end
