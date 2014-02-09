class ShoppingListsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @lists = ShoppingList.all
    render json: @lists.to_json(:include => [{:recipes => {except: [:created_at, :updated_at] }}, {:list_ingredients => {only: [:raw_name] }} ])
  end

  def show
    if ShoppingList.where(:id => params[:id]).any?
      @list = ShoppingList.find(params[:id])
      render json: formatted_list(@list)
    else
      render :json => {:error_message => "no shopping list with id #{params[:id]}"}
    end
  end

  def create
    @list = ShoppingList.find_or_create_by(user_id: params['user']['user_id'])
    @list.update_params(params)
    render json: formatted_list(@list), :status => 201
  end

  def email_list
    @list = ShoppingList.where(:user_id => params["user_id"]).first
    if @list
      ListMailer.shopping_list_email(@list).deliver
      render json: @list, :status => 201
    else
      no_list_error
    end
  end

  def clear_list
    @list = ShoppingList.where(:user_id => params["user_id"]).first
    if @list
      @list.destroy
      render :json => "List Destroyed", :status => 201
    else
      no_list_error
    end
  end

  private

  def no_list_error
    render :json => {:error_message => "list not found"}, :status => 404
  end

  def formatted_list(list)
    list.to_json(:include => [{:recipes => {except: [:created_at, :updated_at] }}, {:list_ingredients => {only: [:raw_name] }} ])
  end

  #curl command

  # curl -X POST -H "Content-Type: application/json" -d "{\"user\":{\"user_id\":1,\"Email\":\"email@example.com\"},\"recipes\":[{\"name\":\"Spicy Avocado Chicken\",\"source_url\":\"http://allrecipes.com/Recipe/spicy-avocado-chicken/detail.aspx\",\"servings\":\"4\",\"ingredients\":[\"1 teaspoon salt\",\"1/4 teaspoon ground black pepper\",\"1/4 teaspoon ground cayenne pepper\",\"4 skinless, boneless chicken breast halves\",\"2 tablespoons olive oil\",\"1 red onion, minced\",\"2 tablespoons lime juice\",\"1 avocado, diced\",\"salt and ground black pepper to taste\",\"salt and ground black pepper to taste\"]},{\"name\":\"Cheesy Chicken and Rice Skillet Dinner with Bacon\",\"source_url\":\"http://picky-palate.com/2012/05/17/cheesy-chicken-and-rice-skillet-dinner-with-bacon/\",\"servings\":\"2\",\"ingredients\":[\"1/2 pound Applewood Smoked Bacon\",\"4 tablespoons unsalted butter\",\"1/4 cup all purpose flour\",\"1/2 teaspoon kosher salt\",\"1/4 teaspoon freshly ground black pepper\",\"1 1/2 cups chicken broth\",\"1 1/2 cups shredded cheddar cheese\",\"1-2 tablespoons Hot Sauce\",\"2 cups cooked shredded chicken\",\"4 cups steamed white rice\",\"1 cup shredded cheddar cheese\"]}]}" http://localhost:3000/shopping-lists
end
