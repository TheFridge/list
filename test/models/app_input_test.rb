require 'test_helper'

class AppInputTest < ActiveSupport::TestCase

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

  def test_it_grabs_all_ingredients
    input = AppInput.new(@data)
    assert_equal 6, input.ingredient_list.count
  end

  def test_it_find_the_quantity_from_first_ingredient
    input = AppInput.new(@data)
    assert_equal "3", Ingredient.get_quantity(input.ingredient_list.first)
  end

  def test_it_creates_a_new_shopping_list
    assert_equal 2, ShoppingList.count
    input = AppInput.new(@data)
    assert_equal ShoppingList, input.shopping_list.class
    assert_equal 3, ShoppingList.count
  end

  def test_it_creates_ingredients
    assert_equal 2, Ingredient.count
    assert_equal 2, ListIngredient.count
    input = AppInput.new(@data)
    input.create_ingredients(1)
    assert_equal 8, Ingredient.count
    assert_equal 8, ListIngredient.count
  end

  def test_creates_full_list
    input = AppInput.new(@data)
    input.create_full_list
    list = ShoppingList.last
    assert_equal "fakeuser@example.com", list.user_email
    assert_equal "butter", list.ingredients.first.name
    assert_equal 1, list.ingredients.first.list_ingredients.count
  end

end



    
    # Thank you for meal planning with us.

    # Your shopping list is:




    # A link to your recipes
    #   name:
    #   link:
