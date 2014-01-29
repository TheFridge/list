class ListIngredient < ActiveRecord::Base
  belongs_to :shopping_list
  belongs_to :ingredient

  validates_presence_of :ingredient_id
  validates_presence_of :shopping_list_id
end
