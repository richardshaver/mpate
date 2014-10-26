class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :password
      t.integer :room
      t.string :security_level

      t.timestamps
    end
  end
end
