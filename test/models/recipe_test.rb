require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def test_recipes_for_user
    recipe1 = Recipe.create({"name"=>"A Good Easy Garlic Chicken", "source_url"=>"www.example.com/CHICKEN", "servings"=>"4", "user_id"=>1})
    recipe2 = Recipe.create({"name"=>"More Chicken", "source_url"=>"www.example.com/CHICKEN", "servings"=>"4", "user_id"=>1})
    recipe3 = Recipe.create({"name"=>"Best Chicken", "source_url"=>"www.example.com/CHICKEN", "servings"=>"4", "user_id"=>5})
    assert  Recipe.recipes_for_user(1).include?(recipe1)
    refute Recipe.recipes_for_user(1).include?(recipe3)
  end

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
