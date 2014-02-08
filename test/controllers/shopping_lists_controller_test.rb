class ShoppingListsControllerTest < ActionController::TestCase
    def setup
    data = {
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

    @list = ShoppingList.new
    @list.update_params(data)
    ActionMailer::Base.delivery_method = :smtp
  end

  def test_responds_to_post_list_method_without_data
    post :email_list
    assert_response 404
  end

  def test_it_responds_post_list_with_data
    post :email_list, {user_id: 20}
    assert_response 201
    #check mail catcher
  end
end
