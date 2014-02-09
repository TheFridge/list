require 'test_helper'

class ShoppingListTest < ActiveSupport::TestCase
  attr_reader :data

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
  end

  def test_it_destroys_dependent_list_ingredients
    list = ShoppingList.new
    list.update_params(data)
    the_list_id = list.id
    assert_equal 6, ListIngredient.where(:shopping_list_id => the_list_id).count
    list.destroy
    assert_equal 0, ListIngredient.where(:shopping_list_id => the_list_id).count
  end

  def test_it_destroys_dependent_recipe_shopping_lists
    list = ShoppingList.new
    list.update_params(data)
    the_list_id = list.id
    assert_equal 2, RecipesShoppingList.where(:shopping_list_id => the_list_id).count
    list.destroy
    assert_equal 0, RecipesShoppingList.where(:shopping_list_id => the_list_id).count   
  end

  def test_it_captures_raw_name
    list = ShoppingList.new
    list.update_params(data)
    assert_equal "3 tablespoons butter", list.list_ingredients.first.raw_name
  end
  
  def test_it_is_associated_with_a_user
    shopping_lists(:one).update(:user_id => nil)
    refute shopping_lists(:one).valid?
  end

  def test_it_has_list_ingredients
    assert_equal 0, shopping_lists(:two).list_ingredients.count
  end

  def test_it_has_ingredients
    assert_equal 0, shopping_lists(:two).ingredients.count
  end

  def test_it_has_a_recipes_array
    list = shopping_lists(:one)
    assert_equal 0, list.recipes.count
  end

  def test_it_updates_params
    list = ShoppingList.new
    list.update_params(data)
    assert_equal "fakeuser@example.com", list.user_email
  end

  def test_it_creates_recipes
    list = shopping_lists(:one)
    list.create_recipes(data)
    assert_equal 4, Recipe.count
    assert_equal 2, list.recipes.count
  end

  def test_it_creates_ingredients
    list = shopping_lists(:two)
    list.create_shopping_list_ingredients(data)
    assert_equal 8, Ingredient.count
    assert_equal 6, list.ingredients.count
    assert_equal "tablespoons", list.list_ingredients.first.measurement
  end
  
  def test_update_params_populates_database
    assert_equal 2, Ingredient.count
    assert_equal 2, ListIngredient.count
    assert_equal 2, Recipe.count
    assert_equal 2, RecipeIngredient.count
    list = ShoppingList.new
    list.update_params(data)
    assert_equal 8, Ingredient.count
    assert_equal 8, ListIngredient.count
    assert_equal 4, Recipe.count
  end
  

end
