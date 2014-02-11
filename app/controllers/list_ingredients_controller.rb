class ListIngredientsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def update
    @list_ingredient = ListIngredient.find(params[:id])
  end

  def destroy
   @list_ingredient = ListIngredient.find_by(id: params[:id])
   if @list_ingredient
      @list_ingredient.destroy
      render :json => {:success_message => "Successfully removed from list"}, :status => 201
    else
      render :json => {:error_message => "Could not remove list ingredient"}, :status => 404
    end
  end
end
