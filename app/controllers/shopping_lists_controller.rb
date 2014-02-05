class ShoppingListsController < ApplicationController
  respond_to :json

  def index
    render json: ShoppingList.all
  end

  def show
    render json: ShoppingList.find(params[:id])
  end

  def create
    @list = ShoppingList.new
    @list.update_params(params)
    render json: @list, :status => 201
  end

  private

  #curl command

  # curl -X POST -H "Content-Type: application/json" -d "{\"user\":{\"user_id\":1,\"email\":\"email@example.com\"},\"recipes\":[{\"name\":\"Spicy Avocado Chicken\",\"source_url\":\"http://allrecipes.com/Recipe/spicy-avocado-chicken/detail.aspx\",\"servings\":\"4\",\"ingredients\":[\"1 teaspoon salt\",\"1/4 teaspoon ground black pepper\",\"1/4 teaspoon ground cayenne pepper\",\"4 skinless, boneless chicken breast halves\",\"2 tablespoons olive oil\",\"1 red onion, minced\",\"2 tablespoons lime juice\",\"1 avocado, diced\",\"salt and ground black pepper to taste\",\"salt and ground black pepper to taste\"]},{\"name\":\"Cheesy Chicken and Rice Skillet Dinner with Bacon\",\"source_url\":\"http://picky-palate.com/2012/05/17/cheesy-chicken-and-rice-skillet-dinner-with-bacon/\",\"servings\":\"2\",\"ingredients\":[\"1/2 pound Applewood Smoked Bacon\",\"4 tablespoons unsalted butter\",\"1/4 cup all purpose flour\",\"1/2 teaspoon kosher salt\",\"1/4 teaspoon freshly ground black pepper\",\"1 1/2 cups chicken broth\",\"1 1/2 cups shredded cheddar cheese\",\"1-2 tablespoons Hot Sauce\",\"2 cups cooked shredded chicken\",\"4 cups steamed white rice\",\"1 cup shredded cheddar cheese\"]}]}" http://localhost:3000/shopping_lists
end
