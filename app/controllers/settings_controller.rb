class SettingsController < ApplicationController
  def index
  	@online = Setting.find_by(key: "online").value
  	@require_school_password = Setting.find_by(key: "require_school_password").value
  end

  def save_all
  	@online = Setting.find_by(key: "online")
  	@require_school_password = Setting.find_by(key: "require_school_password")

  	@online.value = params[:online]
  	@require_school_password.value = params[:require_school_password]

  	@online.save!
  	@require_school_password.save!

  	redirect_to settings_path, notice: "Settings updated."
  end

end
