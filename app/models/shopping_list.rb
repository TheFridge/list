class ShoppingList < ActiveRecord::Base
  has_many :list_ingredients
  has_many :ingredients, through: :list_ingredients
  has_many :recipes_shopping_list
  has_many :recipes, through: :recipes_shopping_list

  validates_presence_of :user_id

  
  def update_params(params)
    data = shopping_list_data(params)
    update_attributes!(:user_id => data["user_id"], :user_email => data["user_email"])
    create_recipes(params)
    create_shopping_list_ingredients(params)
  end

  def shopping_list_data(data)
    {"user_id" => data['user']['user_id'], "user_email" => data['user']['email']}   
  end

  def create_recipes(data)
    data['recipes'].each do |recipe|
      new_recipe = Recipe.create(recipe_data(recipe))
      RecipesShoppingList.create(recipe: new_recipe, shopping_list: self)
    end
  end

  def create_shopping_list_ingredients(data)
    data['recipes'].each do |recipe|
      recipe['ingredients'].each do |ingredient|
        new_ingredient = Ingredient.create(ingredient_data(ingredient.dup))
        ListIngredient.create(list_ingredient_data(ingredient, new_ingredient)) 
      end
    end
  end

  def recipe_data(recipe)
    {"name" => recipe["name"], "source_url" => recipe["source_url"], "servings" => recipe["servings"]}
  end

  def ingredient_data(ingredient)
    {"name" => Ingredient.get_name(ingredient)}
  end

  def list_ingredient_data(string, ingredient)
    qty = Ingredient.get_quantity(string).to_i
    measure = Ingredient.get_measurement(string)
    {"shopping_list_id" => self.id, "quantity" => qty, "measurement" => measure, "ingredient_id" => ingredient.id}
  end

end
