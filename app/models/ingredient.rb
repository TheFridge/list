class Ingredient < ActiveRecord::Base
  has_many :list_ingredients
  has_many :shopping_lists, through: :list_ingredients
  has_many :recipes, through: :recipe_ingredients
  validates_presence_of :name

  def self.get_quantity(raw_ingredient)
    raw_ingredient.split.select do |char|
      char =~ /[[:digit:]]/
    end.first
  end

  def self.get_measurement(raw_ingredient)
    raw_ingredient.downcase.split.select do |word|
      acceptable_measurements.include?(word)
    end.first
  end

  def self.get_name(raw_ingredient)
    quantity = self.get_quantity(raw_ingredient)
    measure = self.get_measurement(raw_ingredient)
    if quantity
      raw_ingredient.gsub!(quantity, "")
    end
    if measure
      raw_ingredient.gsub!(measure, "")
    end
    raw_ingredient.strip
  end

  def self.acceptable_measurements
    ['teaspoon', 'teaspoons', 't', 'tsp', 'cup', 'cups', 'pound', 'pounds', 'tablespoon', 
      'tablespoons', 'tbl', 'tbs', 'tbsp', 'ounce', 'ounces', 'oz', 'fl oz', 'pint', 'pints', 'quart', 'quarts',
      'gallon', 'gallons', 'ml', 'liter', 'litre', 'l']
  end
end
