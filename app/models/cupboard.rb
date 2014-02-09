class Cupboard < ActiveRecord::Base
  has_many :cupboard_ingredients, dependent: :destroy
  has_many :ingredients, through: :cupboard_ingredients
  validates_presence_of :user_id

  def migrate_shopping_list
    list = ShoppingList.where({:user_id => self.user_id}).first
    list.list_ingredients.each do |list_ingredient|
      formatting = CupboardIngredient.format_list_ingredient(list_ingredient)
      if find_cu(list_ingredient.ingredient_id)
        find_cu(list_ingredient.ingredient_id).update_ingrediedfahbnts(formatting)
      else
      cu = CupboardIngredient.new(formatting)
      cu.cupboard_id = self.id
      cu.save
      end
    end
    list.destroy
  end

  def find_cu(id)
    self.cupboard_ingredients.find_by(ingredient_id: id)
  end

  def any_matching_ingredients?(id)
    self.cupboard_ingredients.where(ingredient_id: id).any?
  end
end
