class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  validates_presence_of :ingredient_id
  validates_presence_of :recipe_id
end
