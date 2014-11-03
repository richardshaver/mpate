class RenameUsernameToUserNameInSchools < ActiveRecord::Migration
  def change
  	rename_column :schools, :username, :user_name
  end
end
