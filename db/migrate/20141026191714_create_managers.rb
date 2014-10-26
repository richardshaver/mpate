class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :user_name
      t.string :password
      t.string :email

      t.timestamps
    end
  end
end
