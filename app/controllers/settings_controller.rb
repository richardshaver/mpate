class SettingsController < ApplicationController
  def index
  	@online_status = Setting.find_by(key: "online")
  end

  def update
  	@online_status = Setting.find_by(key: "online")
  	@online_status.value = params[:setting][:value]
  	@online_status.save
    redirect_to settings_path, notice: "System Status Changed"
  end

end
