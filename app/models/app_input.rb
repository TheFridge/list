class AppInput

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def create_full_list
    list = ShoppingList.create(shopping_list_data)
    all_recipes.each do |recipe|
      new_recipe = Recipe.create(recipe_data(recipe))
      recipe["ingredients"].each do |ingredient|
        new_ingredient = Ingredient.create(ingredient_data(ingredient))
        RecipeIngredient.create("ingredient_id" => new_ingredient.id, "recipe_id" => new_recipe.id )
        list_ingredient = ListIngredient.new(list_ingredient_data(ingredient))
        list_ingredient.shopping_list_id = list.id
        list_ingredient.ingredient_id = new_ingredient.id
        list_ingredient.save
      end
    end
  end

  def shopping_list_data
    {"user_id" => data['user']['user_id'], "user_email" => data['user']['email']}
  end

  def recipe_data(recipe)
    {"name" => recipe["name"], "source_url" => recipe["source_url"], "servings" => recipe["servings"]}
  end

  def ingredient_data(ingredient)
    {"name" => Ingredient.get_name(ingredient)}
  end

  def list_ingredient_data(ingredient)
    qty = Ingredient.get_quantity(ingredient).to_i
    measure = Ingredient.get_measurement(ingredient)
    {"quantity" => qty, "measurement" => measure}
  end

  def all_recipes
    data['recipes']
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
