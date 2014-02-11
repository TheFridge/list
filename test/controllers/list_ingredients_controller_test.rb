class ListIngredientsControllerTest < ActionController::TestCase

  def test_it_destroys_a_list_ingredient
    delete :destroy, id: list_ingredients(:one).id
    assert_response 201
  end

  def test_it_returns_an_error
    delete :destroy, id: 44
    assert_response 404
  end

end
