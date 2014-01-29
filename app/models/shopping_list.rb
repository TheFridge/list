class ShoppingList < ActiveRecord::Base
  has_many :list_ingredients
  has_many :ingredients, through: :list_ingredients
  validates_presence_of :user_id
end
