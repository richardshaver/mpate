class ChangeLeaderRoomToText < ActiveRecord::Migration
  def change
  	change_column :leaders, :room, :string
  end
end
