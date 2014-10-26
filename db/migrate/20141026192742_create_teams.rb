class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :number
      t.string :color
      t.integer :score_one
      t.integer :score_two
      t.integer :score_three
      t.integer :score_four

      t.timestamps
    end
  end
end
