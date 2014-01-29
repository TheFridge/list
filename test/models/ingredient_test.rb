require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  def test_ingredient_must_have_a_name
    ingredients(:one).update(name: nil)
    refute ingredients(:one).valid?  
  end
end
