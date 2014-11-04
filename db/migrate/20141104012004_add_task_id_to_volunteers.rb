class AddTaskIdToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :task_id, :integer
  end
end
