class RecipeIngredientsController < ApplicationController
  
  def index
    @recipe_ingredients = RecipeIngredient.all
  end

  def show
  end

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def edit
  end
  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)

    respond_to do |format|
      if @recipe_ingredient.save
        format.json { render action: 'show', status: :created, location: @recipe_ingredient }
      else
        format.json { render json: @recipe_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe_ingredient.update(recipe_ingredient_params)
        format.json { head :no_content }
      else
        format.json { render json: @recipe_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_ingredient.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
   
    def set_recipe_ingredient
      @recipe_ingredient = RecipeIngredient.find(params[:id])
    end

    def recipe_ingredient_params
      params[:recipe_ingredient]
    end
end
