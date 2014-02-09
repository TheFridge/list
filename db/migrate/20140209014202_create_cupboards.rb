class CreateCupboards < ActiveRecord::Migration
  def change
    create_table :cupboards do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
