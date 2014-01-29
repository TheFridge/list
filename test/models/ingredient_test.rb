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
end
