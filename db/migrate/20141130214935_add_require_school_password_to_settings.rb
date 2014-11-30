class AddRequireSchoolPasswordToSettings < ActiveRecord::Migration
  def change
    Setting.create key: "require_school_password", value: "no"
  end
end
