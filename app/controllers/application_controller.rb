class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make sure only the manager can access the site when it's offline.

  before_filter :is_offline?

  # Variable to keep track of whether the system is offline
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

  # The opposite of is_offline, but easier to use in some places in the code
  def is_online?
    online_status = Setting.find_by(key: "online")
    online_status.value == "yes"
  end

  # Set up login authentication variables to keep track of access permissions

  # Check if the user is currently logged in
  def is_logged_in?
  	if session[:user] && session[:user] != nil
  		true
  	else
  		false
  	end
  end

  # If user is logged in, are they logged in as a manager?
  def is_manager?
  	return false unless is_logged_in?
  	return session[:type] == "manager"
  end

  # If user is logged in, are they logged in as a room leader?
  def is_leader?
  	return false unless is_logged_in?
  	return session[:type] == "leader" && session[:taskmaster] == false
  end

  # If user is logged in, are they logged in as a school level aurhority (for school and competitor signups)
  def is_school?
  	return false unless is_logged_in?
  	return session[:type] == "school"
  end

  # If the user is logged in, are they logged in as a taskmaster?
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
  helper_method :is_online?

  # Keeps track of whether schools and competitors need to log in to signup
  def require_school_password?
    Setting.find_by(key: "require_school_password").value == "yes"
  end

  helper_method :require_school_password?

end
