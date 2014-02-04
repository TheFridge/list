class AppInput

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def ingredient_list
    the_array = []
    data["recipes"].each do |recipe|
      recipe["ingredients"].each do |ingredient|
        #new_ingredient = Ingredient.new(ingredient)
        the_array << ingredient
      end
    end
    the_array
  end



end
