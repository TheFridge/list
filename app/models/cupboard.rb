class Cupboard < ActiveRecord::Base
  has_many :cupboard_ingredients, dependent: :destroy
  has_many :ingredients, through: :cupboard_ingredients
  validates_presence_of :user_id

  def migrate_shopping_list
    list = ShoppingList.where({:user_id => self.user_id}).first
    list.list_ingredients.each do |list_ingredient|
      formatting = CupboardIngredient.format_list_ingredient(list_ingredient)
      cu = CupboardIngredient.new(formatting)
      cu.cupboard_id = self.id
      cu.save
    end
    list.destroy
  end
end
