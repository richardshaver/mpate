class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :msu_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :ref_instructor

      t.timestamps
    end
  end
end
