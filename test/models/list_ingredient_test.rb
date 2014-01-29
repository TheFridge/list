require 'test_helper'

class ListIngredientTest < ActiveSupport::TestCase
 
  def test_it_must_belong_to_ingredient
    assert list_ingredients(:one).valid?
    assert_equal "Tomato", list_ingredients(:one).ingredient.name
    list_ingredients(:one).update(:ingredient_id => nil)
    refute list_ingredients(:one).valid?
  end

  def test_it_must_belong_to_a_shopping_list
    assert list_ingredients(:one).valid?
    assert_equal shopping_lists(:one).id, list_ingredients(:one).shopping_list.id
    list_ingredients(:one).update(:shopping_list_id => nil)
    refute list_ingredients(:one).valid?
  end
end
