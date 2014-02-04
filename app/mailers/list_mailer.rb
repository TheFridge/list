class ListMailer < ActionMailer::Base
  default from: "thefridgeco@gmail.com"

  def shopping_list_email(list)
    @list = list
    @recipes = list.recipes
    @list_ingredients = list.list_ingredients
    mail(to: @list.user_email, subject: 'Your Shopping List from The Fridge')
  end
end
