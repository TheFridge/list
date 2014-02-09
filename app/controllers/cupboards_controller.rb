class CupboardsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    if params['user_id'] && Cupboard.find_or_create_by(user_id: params['user_id'])
      render json: @cupboard, :status => 201
    else
      render :json => {:error_message => "cupboard could not save"}, :status => 404  
    end
  end
end
