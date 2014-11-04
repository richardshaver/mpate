class AddTeamIdToCompetitors < ActiveRecord::Migration
  def change
    add_column :competitors, :team_id, :integer
  end
end
