class Ingredient < ActiveRecord::Base
  has_many :list_ingredients
  has_many :shopping_lists, through: :list_ingredients
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
    ['teaspoon', 'teaspoons', 't', 'tsp', 'cup', 'cups', 'pound', 'pounds', 'tablespoon', 'tablespoons', 'tbl', 'tbs', 'tbsp', 'ounce', 'fl oz']
  end
# gill (about 1/2 cup)
# cup (also c)
# pint (also p, pt, or fl pt - Specify Imperial or US)
# quart (also q, qt, or fl qt - Specify Imperial or US)
# gallon (also g or gal - Specify Imperial or US)
# ml, also milliliter, millilitre, cc (and mL only in the US, Canada and Australia).
# l, also liter, litre, (and L only in the US, Canada and Australia).
# dl, also deciliter, decilitre (and dL only in the US, Canada and Australia).]
#   end
end
