class RecipesControllerTest < ActionController::TestCase
  
  def test_it_shows_recipes
    Recipe.create({"name"=>"A Good Easy Garlic Chicken", "source_url"=>"www.example.com/CHICKEN", "servings"=>"4", "user_id"=>1})
    Recipe.create({"name"=>"Best Chicken", "source_url"=>"www.example.com/CHICKEN", "servings"=>"4", "user_id"=>5})
    get :user_recipes, {user_id: 1}
    assert_response 200
    assert response.body.include?('A Good Easy Garlic Chicken')
    refute response.body.include?('Best Chicken')
  end
end
