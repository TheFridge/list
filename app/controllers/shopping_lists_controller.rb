class ShoppingListsController < ApplicationController

  def show
    render json: ShoppingList.find(params[:id])
  end

  def create
    input = AppInput.new(shopping_list_params)
    input.create_full_list
    render json: {message: "Your message was sent"}, :status => 201
  end

  private

end
