require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def test_recipe_must_have_a_name
    recipes(:one).update(name: nil)
    refute recipes(:one).valid?  
  end

  def test_recipe_has_many_list_recipes
    assert_equal 0, recipes(:two).recipe_ingredients.count
  end

  def test_it_has_many_ingredients
    assert_equal 0, recipes(:two).ingredients.count
    # assert_equal 1, shopping_lists(:one).recipes.count
  end
end
