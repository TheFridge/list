require 'test_helper'

class CupboardTest < ActiveSupport::TestCase
  def test_cupboard_must_have_user_id
    cupboards(:one).update(user_id: nil)
    refute cupboards(:one).valid?  
  end

  def test_cupboard_has_cupboard_ingredients
    assert_equal 0, cupboards(:two).cupboard_ingredients.count
  end

  def test_migrate_shopping_list_clears_shopping_list
    list = shopping_lists(:one)
    assert_equal 1, ShoppingList.where({:user_id => list.user_id}).count
    assert_equal 1, list.ingredients.count
    cupboards(:one).migrate_shopping_list
    assert_equal 0, list.ingredients.count
  end

  def test_migrate_shopping_list_transfers_ingredients_to_list_cupboard
    list = shopping_lists(:one)
    assert_equal 3, list.list_ingredients.first.quantity
    assert_equal 'cups', list.list_ingredients.first.measurement
    assert_equal 'Tomato', list.list_ingredients.first.ingredient.name
    cupboards(:one).migrate_shopping_list
    assert_equal 1, cupboards(:one).cupboard_ingredients.count
    assert_equal 3, cupboards(:one).cupboard_ingredients.first.quantity
    assert_equal 'cups', cupboards(:one).cupboard_ingredients.first.measurement
    assert_equal 'Tomato', cupboards(:one).cupboard_ingredients.first.ingredient.name
  end

  def test_migrate_shopping_list_adjusts_for_quantity
    skip
  end
end
