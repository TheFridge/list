class ShoppingListsControllerTest < ActionController::TestCase
    def setup
    @data = {
    "user" => {
      "user_id" => 20,
      "email" => 'email_shopping_list_user@example.com'
     },
     "recipes" => [
        {"name" => "A Good Easy Garlic Chicken",
        "source_url" => "www.example.com/CHICKEN",
        "servings" => "4",
        "ingredients" => [
          '3 tablespoons butter',
          '4 skinless, boneless chicken breast halves',
          '2 teaspoons garlic powder'
          ]
        },
        {"name" => "Bombay Cherry",
        "source_url" => "www.example.com/bombay_cherry",
        "servings" => "1",
        "ingredients" => [
          '8 cups paprika',
          '7 cherries',
          'All the teaspoons of chickpeas'
          ]
        }
      ]
    }
    ActionMailer::Base.delivery_method = :smtp
    end

  def test_it_creates_new_list
    #list = ShoppingList.find_or_initialize_by(user_id: @data['user']['user_id'])
    #recipe = Recipe.find_or_create_by(list.recipe_data(@data['recipes'].first))
    #assert_equal "boo", RecipesShoppingList.find_or_create_by(recipe: recipe, shopping_list: list)
    #assert_equal "boo",  @data['recipes']
    post :create, @data
    assert response.body.match(/paprika/)
    refute response.body.match(/strawberries/)
  end

  def test_it_appends_to_list
    post :create, @data
    first_list_id = ShoppingList.all.last.id
    new_data = @data.dup
    new_data['recipes'] = [
        {"name" => "Strawberry Short Cake",
        "source_url" => "www.example.com/ShortCake",
        "servings" => "8",
        "ingredients" => [
          '9 strawberries',
          '1 Cake',
          '1 can whipped cream'
          ]
        }
      ]
    post :create, new_data
    assert_equal first_list_id, ShoppingList.all.last.id
    assert response.body.match(/paprika/)
    assert response.body.match(/strawberries/)
  end

  def test_responds_to_post_list_method_without_data
    post :email_list
    assert_response 404
  end

  def test_it_responds_post_list_with_data
    @list = ShoppingList.new
    @list.update_params(@data)
    post :email_list, {user_id: 20}
    assert_response 201
    #check mail catcher
  end
end
