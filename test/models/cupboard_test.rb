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
  
  def test_migrate_shopping_list_error
    cupboard_without_a_list = Cupboard.create(user_id: 59)
    assert_raises(ArgumentError){cupboard_without_a_list.migrate_shopping_list}
  end

  def test_migrate_shopping_list_adjusts_for_quantity
    skip
    list = shopping_lists(:one)
    cupboards(:one).migrate_shopping_list
    assert_equal 1, cupboards(:one).cupboard_ingredients.count
    list_two = ShoppingList.create(:user_id => cupboards(:one).user_id)
    ingredient_id = cupboards(:one).cupboard_ingredients.first.ingredient_id
    ListIngredient.create(:shopping_list_id => list_two.id, :ingredient_id => ingredient_id, :measurement => "cups",  :quantity => 3)
    cupboards(:one).migrate_shopping_list
    assert_equal 1, cupboards(:one).cupboard_ingredients.count
    assert_equal 6, cupboards(:one).cupboard_ingredients.first.quantity
  end

  def test_any_matching_ingredients
    refute cupboards(:one).any_matching_ingredients?(1)
    CupboardIngredient.create(cupboard_id: cupboards(:one).id, ingredient_id: 1)
    assert cupboards(:one).any_matching_ingredients?(1)
  end

  def test_find_cupboard_ingredient
    assert_equal nil, cupboards(:one).find_cu(1)
    CupboardIngredient.create(cupboard_id: cupboards(:one).id, ingredient_id: 1)
    assert_equal CupboardIngredient, cupboards(:one).find_cu(1).class 
  end
end
