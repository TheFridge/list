class Cupboard < ActiveRecord::Base
  has_many :cupboard_ingredients, dependent: :destroy
  has_many :ingredients, through: :cupboard_ingredients
  validates_presence_of :user_id

  def migrate_shopping_list
    begin
      list = ShoppingList.where({:user_id => self.user_id}).first
      create_cupboard_ingredients(list)
      list.destroy
    rescue Exception
      raise ArgumentError, Time.now.to_s + " Something went wrong with the migration"
    end
  end
  
  def populate
    if ShoppingList.where({:user_id => self.user_id}).any?
      migrate_shopping_list
    end
  end

  def create_cupboard_ingredients(list)
    list.list_ingredients.each do |list_ingredient|
      formatting = CupboardIngredient.format_list_ingredient(list_ingredient)
      cu = CupboardIngredient.new(formatting)
      cu.cupboard_id = self.id
      cu.save
    end
  end

#Below punted until ingredients come in from front end

  def update_quantity
    # if find_cu(list_ingredient.ingredient_id)
    # find_cu(list_ingredient.ingredient_id).update_ingredients(formatting)
    # else
    #end
  end

  def find_cu(id)
    self.cupboard_ingredients.find_by(ingredient_id: id)
  end

  def any_matching_ingredients?(id)
    self.cupboard_ingredients.where(ingredient_id: id).any?
  end
end
