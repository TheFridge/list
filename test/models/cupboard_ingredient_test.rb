require 'test_helper'

class CupboardIngredientTest < ActiveSupport::TestCase
  def test_it_formats_valid_list_ingredients
    format = CupboardIngredient.format_list_ingredient(list_ingredients(:one))
    formatted_hash = {:quantity=>3, :measurement=>"cups", :ingredient_id=>980190962}
    assert_equal formatted_hash, format
  end
end
