class CupboardsControllerTest < ActionController::TestCase

  def test_it_creates_a_cupboard
    post :create, {user_id: 20}
    assert_response 201
  end

  def test_it_returns_an_error_for_invalid_creation
    post :create
    assert_response 404
  end

  def test_it_populates_cupboard_ingredients
    
  end

end
