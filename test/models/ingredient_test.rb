require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  def test_ingredient_must_have_a_name
    ingredients(:one).update(name: nil)
    refute ingredients(:one).valid?  
  end

  def test_ingredient_has_many_list_ingredients
    assert_equal 0, ingredients(:two).list_ingredients.count
  end

  def test_it_has_many_shopping_lists
    assert_equal 0, ingredients(:two).shopping_lists.count
    # assert_equal 1, shopping_lists(:one).ingredients.count
  end

  def test_formatting_quantity_strings
    qty = Ingredient.get_quantity("3 cups Peas")
    assert_equal "3", qty
  end

  def test_formatting_quantity_strings_fraction
    qty = Ingredient.get_quantity("1/2 cup Peas")
    assert_equal "1/2", qty
  end

  def test_formatting_quantity_strings_large_number
    qty = Ingredient.get_quantity("1000000 cups Peas")
    assert_equal "1000000", qty
  end

  def test_formatting_quantity_strings_strange_number
    qty = Ingredient.get_quantity("1 1/2 pounds skinless, boneless chicken breast halves - cut into strips")
    qty2 = Ingredient.get_quantity("1 (10.75 ounce) can condensed low fat cream of chicken and herbs soup")
    assert_equal "1 1/2", qty
    assert_equal "1 (10.75)", qty2
  end

  def test_formatting_quantity_range
    qty = Ingredient.get_quantity("8-12 flour tortillas")
    assert_equal "8-12", qty
  end

  def test_formatting_quantity_no_number
    qty = Ingredient.get_quantity("tortillas")
    assert_equal nil, qty
  end

  def test_formatting_measurements
    measure = Ingredient.get_measurement("3 cups Peas")
    assert_equal 'cups', measure
  end

  def test_formatting_no_measurements
    measure = Ingredient.get_measurement("3 chickens")
    assert_equal nil, measure
  end

  def test_formatting_the_name
    name = Ingredient.get_name("3/4 cups Peas")
    assert_equal "Peas", name
  end

  def test_formatting_the_name_without_measurements_and_qty
    name = Ingredient.get_name("Flour Tortillas")
    assert_equal "Flour Tortillas", name
  end

  def test_formatting_the_with_only_quantity
    name = Ingredient.get_name("3 Blackened Chickens")
    assert_equal "Blackened Chickens", name
  end
end
