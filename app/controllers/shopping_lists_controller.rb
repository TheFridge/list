
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

  #def formatted_list(list)
  #  list.to_json(:include => [{:recipes => {except: [:created_at, :updated_at] }}, {:list_ingredients => {only: [:raw_name] }} ])
  #end

  def formatted_list(list)
    ingredients = list.list_ingredients.map do |li|
      {'list_ingredient_id' => li.id,
       'quantity' => li.quantity,
       'measurement' => li.measurement,
       'raw_name' => li.raw_name,
       'name' => li.ingredient.name,
       'ingredient_id' => li.ingredient.id,
       'tag' => li.ingredient.tag
      }
    end
    {'shopping_list' => list, 'ingredients' => ingredients, 'recipes' => list.recipes }.to_json
  end
end
