class AppInput

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def create_full_list
    list_id = shopping_list.id
    create_ingredients(list_id)
  end

  def shopping_list
    list = ShoppingList.new
    list.user_id = data['user']['user_id']
    list.user_email = data['user']['email']
    list.save
    list
  end

  def create_ingredients(list_id)
    ingredient_list.each do |ingredient_string|
      qty = Ingredient.get_quantity(ingredient_string)
      measure = Ingredient.get_measurement(ingredient_string)
      name = Ingredient.get_name(ingredient_string)
      new_ingredient = Ingredient.create(name: name)
      ListIngredient.create(shopping_list_id: list_id, ingredient_id: new_ingredient.id, quantity: qty, measurement: measure)
    end
  end

  def ingredient_list
    the_array = []
    data["recipes"].each do |recipe|
      recipe["ingredients"].each do |ingredient|
        the_array << ingredient
        ingredient
      end
    end
    the_array
  end
end
