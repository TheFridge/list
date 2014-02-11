class RecipesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.json { render action: 'show', status: :created, location: @recipe }
      else
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.json { head :no_content }
      else
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @recipe.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def user_recipes
    @recipes = Recipe.recipes_for_user(params['user_id'])
    render json: @recipes.to_json
  end
    
  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end


    def recipe_params
      params[:recipe]
    end
end
