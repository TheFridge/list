require 'test_helper'

class ShoppingListTest < ActiveSupport::TestCase
  
  def test_it_is_associated_with_a_user
    list = shopping_lists(:one).update(:user_id => nil)
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
end
