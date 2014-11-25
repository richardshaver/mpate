class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make sure only the manager can access the site when it's offline.

  before_filter :is_offline?

  def is_offline?
    online_status = Setting.find_by(key: "online")
    if online_status.value == "no"

      # End any current logged in sessions by non-managers
      unless is_manager?
        session[:user] = nil

        # Redirect to the root url.
        if params[:controller] != "main" && params[:controller] != "sessions"
          redirect_to root_path
        end
      end
    end
  end

  # Set up login authentication variables
  # to keep track of access permissions

  def is_logged_in?
  	if session[:user] && session[:user] != nil
  		true
  	else
  		false
  	end
  end

  def is_manager?
  	return false unless is_logged_in?
  	return session[:type] == "manager"
  end

  def is_leader?
  	return false unless is_logged_in?
  	return session[:type] == "leader" && session[:taskmaster] == false
  end

  def is_school?
  	return false unless is_logged_in?
  	return session[:type] == "school"
  end

  def is_taskmaster?
  	return false unless is_logged_in?
  	return session[:taskmaster] == true
  end

  # Set up helpers so the login permissions 
  # can be accessed throughout the application

  helper_method :is_logged_in?
  helper_method :is_manager?
  helper_method :is_leader?
  helper_method :is_school?
  helper_method :is_taskmaster?

end
