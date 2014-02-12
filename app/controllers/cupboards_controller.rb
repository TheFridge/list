class CupboardsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    if params['user_id'] && Cupboard.find_or_create_by(user_id: params['user_id'])
      @cupboard = Cupboard.find_by(user_id: params['user_id'])
      @cupboard.populate
      render json: formatted_cupboard(@cupboard), :status => 201
    else
      render :json => {:error_message => "cupboard could not save"}, :status => 404
    end
  end

  def show
    if Cupboard.where(:user_id => params[:id]).any?
      @cupboard = Cupboard.find_by(user_id: params['id'])
      render json: formatted_cupboard(@cupboard)
    else
      render :json => {:error_message => "no cupboard with id #{params[:id]}"}
    end
  end

  def destroy
    if Cupboard.where(:user_id => params[:id]).any?
      @cupboard = Cupboard.find_by(user_id: params[:id])
      @cupboard.destroy
    else
      render :json => {:error_message => "no cupboard with user_id #{params[:id]}"}
    end
  end

  def drop_all_items
    if Cupboard.where(user_id: params['user_id']).any?
      @cupboard = Cupboard.find_by(user_id: params['user_id'])
      @cupboard.cupboard_ingredients.each(&:destroy)
    else
      render :json => {:error_message => "Couldn't delete items for user with id #{params['user_id']}"}
    end
  end

  def drop_item
    if Cupboard.where(user_id: params['user_id']).any?
      @cupboard = Cupboard.find_by(user_id: params['user_id'])
      ingredient = @cupboard.cupboard_ingredients.find(params['cupboard_ingredient_id'])
      ingredient.destroy
    else
      render :json => {:error_message => "Couldn't delete ingredient with id #{params['cupboard_ingredient_id']}"}
    end
  end

  def add_ingredient
    if Cupboard.where(user_id: params['user_id']).any?
      @cupboard = Cupboard.find_by(user_id: params['user_id'])
      ingredient = Ingredient.create(:name => params['ingredient'])
      @cupboard.ingredients << ingredient
      cupboard_ingredient = @cupboard.cupboard_ingredients.find_by(:ingredient_id => ingredient.id)
      cupboard_ingredient.quantity = params['quantity']
      cupboard_ingredient.measurement = params['measurement']
      cupboard_ingredient.save
    else
      render :json => {:error_message => "Couldn't add #{params['ingredient']}"}
    end
  end

  def update_quantity
    if Cupboard.where(user_id: params['user_id']).any?
      @cupboard = Cupboard.find_by(user_id: params['user_id'])
      ingredient = @cupboard.cupboard_ingredients.find(params['cupboard_ingredient_id'])
      ingredient.quantity = params['quantity']
      ingredient.quantity < 0 ? ingredient.destroy : ingredient.save
    else
      render :json => {:error_message => "Couldn't update ingredient with id #{params['cupboard_ingredient_id']}"}
    end
  end

  private

  def formatted_cupboard(cupboard)
    ingredients = cupboard.cupboard_ingredients.map do |cu|
      { 'cupboard_ingredient_id' => cu.id,
        'name' => cu.ingredient.name,
        'ingredient_id' => cu.ingredient_id,
        'quantity' => cu.quantity,
        'measurement' => cu.measurement,
        'tag' => cu.ingredient.tag }
    end
    {'cupboard' => cupboard, 'ingredients' => ingredients }.to_json
  end
end

#curl command

# curl -X POST -H "Content-Type: application/json" -d "{\"user_id\":1}" http://localhost:3000/cupboards
