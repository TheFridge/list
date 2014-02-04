class AddEmailToUser < ActiveRecord::Migration
  def change
    add_column :shopping_lists, :user_email, :string
  end
end
