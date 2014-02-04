require 'test_helper'

class ListMailerTest < ActionMailer::TestCase
    def setup
    data = {
    "user" => {
      "user_id" => 1,
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

    input = AppInput.new(data)
    input.create_full_list
    ActionMailer::Base.delivery_method = :smtp
  end

  def test_it_creates_user_mailer
    list = ShoppingList.last
    ListMailer.shopping_list_email(list).deliver
    #check in mailcatcher
  end
end
