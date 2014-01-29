require 'test_helper'

class ShoppingListTest < ActiveSupport::TestCase
  
  def test_it_is_associated_with_a_user
    list = shopping_lists(:one).update(:user_id => nil)
    refute shopping_lists(:one).valid?
  end

  def test_it_has_list_ingredients
    assert_equal 0, shopping_lists(:two).list_ingredients.count

    # assert_equal 1, shopping_lists(:one).ingredients.count
  end

  def test_it_has_ingredients
    assert_equal 0, shopping_lists(:two).ingredients.count
    # assert_equal 1, shopping_lists(:one).ingredients.count
  end
end
