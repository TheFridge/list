class ShoppingListsController < ApplicationController

  def show
    render json: ShoppingList.find(params[:id])
  end

  def create
    list = ShoppingList.new
    list.update_params(params)
    render json: list, :status => 201
  end

  private
end
