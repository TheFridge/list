class ShoppingListsControllerTest < ActionController::TestCase
    def setup
    @data = {
    "user" => {
      "user_id" => 20,
      "email" => 'fakeuser@example.com'
     },
     "recipes" => [
        {"name" => "A Good Easy Garlic Chicken",
        "source_url" => "www.example.com/CHICKEN",
        "servings" => "4",
        "ingredients" => [
          '3 tablespoons butter',
          '4 skinless, boneless chicken breast halves',
          '2 teaspoons garlic powder'
          ],
        "ingredient_list" => [
          'butter',
          'chicken',
          'garlic powder'
        ]
        },
        {"name" => "Bombay Cherry",
        "source_url" => "www.example.com/bombay_cherry",
        "servings" => "1",
        "ingredients" => [
          '8 cups paprika',
          '7 cherries',
          'All the teaspoons of chickpeas'
        ],
        "ingredient_list" => [
          'paprika',
          'cherries',
          'chickpeas'
        ]
        }
      ]
    }
    ActionMailer::Base.delivery_method = :smtp
    end

  def test_it_creates_new_list
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
          ],
        'ingredient_list' => [
          'strawberries',
          'cake',
          'whipped cream'
        ]
        }
      ]
    post :create, new_data
    assert_equal first_list_id, ShoppingList.all.last.id
    assert response.body.match(/paprika/)
    assert response.body.match(/strawberries/)
    list = ShoppingList.all.last
    ListMailer.shopping_list_email(list).deliver
    #check mailer for updated list
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
  
  def test_it_clears_list
    assert_equal 2, ShoppingList.count
    post :create, @data
    assert_equal 3, ShoppingList.count
    post :clear_list, {user_id: 20}
    assert_response 201
    assert_equal 2, ShoppingList.count
  end
end
