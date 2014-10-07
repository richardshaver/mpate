class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :username
      t.string :password
      t.string :school_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone
      t.text :teachers_attending

      t.timestamps
    end
  end
end
