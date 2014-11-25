class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.string :value 
      t.timestamps
    end
    Setting.create key: "online", value: "yes"
  end
end
