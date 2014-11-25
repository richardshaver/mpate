class AddRoomAssignmentsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :room_1, :string
    add_column :teams, :room_2, :string
    add_column :teams, :room_3, :string
    add_column :teams, :room_4, :string
  end
end
