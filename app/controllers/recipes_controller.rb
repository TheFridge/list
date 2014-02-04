class RecipesController < ApplicationController

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

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end


    def recipe_params
      params[:recipe]
    end
end
