class CupboardIngredient < ActiveRecord::Base
  belongs_to :cupboard
  belongs_to :ingredient

  def self.format_list_ingredient(li)
    {quantity: li.quantity, measurement: li.measurement, ingredient_id: li.ingredient_id} 
  end
end
