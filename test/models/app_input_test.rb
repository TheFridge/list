require 'test_helper'

class AppInputTest < ActiveSupport::TestCase

  attr_reader :input

  def setup
    @data = {
    "user" => {
      "user_id" => 1,
      "email" => 'fakeuser@example.com'
     },
     "recipes" => [
        {"name" => "A Good Easy Garlic Chicken",
        "source_url" => "www.example.com/CHICKEN",
        "servings" => "4",
        "ingredients" => [
          '3 tablespoons butter',
          '4 skinless, boneless chicken breast halves',
          '2 teaspoons garlic powder'
          ]
        },
        {"name" => "Bombay Cherry",
        "source_url" => "www.example.com/bombay_cherry",
        "servings" => "1",
        "ingredients" => [
          '8 cups paprika',
          '7 cherries',
          'All the teaspoons of chickpeas'
          ]
        }
      ]
    }

    @input = AppInput.new(@data)
  end

  def test_create_full_list_populates_database
    assert_equal 2, Ingredient.count
    assert_equal 2, ListIngredient.count
    assert_equal 2, Recipe.count
    assert_equal 0, RecipeIngredient.count
    input.create_full_list
    assert_equal 8, Ingredient.count
    assert_equal 8, ListIngredient.count
    assert_equal 4, Recipe.count
    assert_equal 6, RecipeIngredient.count
  end

  def test_create_full_list_creates_recipes
    input.create_full_list
    cherry = Recipe.last
    assert_equal "Bombay Cherry", cherry.name
    assert_equal 3, cherry.ingredients.count
  end

  def test_shopping_list_data_valid
    assert ShoppingList.new(input.shopping_list_data).valid?
  end

  def test_recipe_data_valid
    one_recipe = @data["recipes"].first
    assert Recipe.new(input.recipe_data(one_recipe)).valid?
  end

  def test_ingredient_data_valid
    one_ingredient = @data["recipes"].first["ingredients"].first
    assert Ingredient.new(input.ingredient_data(one_ingredient)).valid?
  end

  def test_list_ingredient_data_valid
    one_ingredient = @data["recipes"].first["ingredients"].first
    ingredient_hash = {"quantity"=>3, "measurement"=>"tablespoons"}
    assert_equal ingredient_hash, input.list_ingredient_data(one_ingredient)
  end

  def test_it_grabs_all_ingredients
    input = AppInput.new(@data)
    assert_equal 6, input.ingredient_list.count
  end

  def test_it_find_the_quantity_from_first_ingredient
    input = AppInput.new(@data)
    assert_equal "3", Ingredient.get_quantity(input.ingredient_list.first)
  end
end



    
    # Thank you for meal planning with us.

    # Your shopping list is:




    # A link to your recipes
    #   name:
    #   link:
