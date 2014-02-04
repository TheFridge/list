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

  def test_it_pulls_ingredients_and_stores_them
    skip
    assert_equal 2, Ingredient.count
    input = AppInput.new(@data)
    assert_equal 8, Ingredient.count
  end

end



    
    # Thank you for meal planning with us.

    # Your shopping list is:




    # A link to your recipes
    #   name:
    #   link:
