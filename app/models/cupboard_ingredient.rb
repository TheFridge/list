class CupboardIngredient < ActiveRecord::Base
  belongs_to :cupboard
  belongs_to :ingredient

  def self.format_list_ingredient(li)
    {quantity: li.quantity, measurement: li.measurement, ingredient_id: li.ingredient_id} 
  end

  def self.create_and_adjust(formatted_hash)
    #cu = self.find_of_create_by!(formatted_hash[:ingredient_id])
    #cu.update_attributes!(formatted_hash)
  end
end
