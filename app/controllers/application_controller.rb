class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
  	return session[:type] == "leader"
  end

  def is_school?
  	return false unless is_logged_in?
  	return session[:type] == "school"
  end

  def is_taskmaster?
  	return false unless is_logged_in?
  	return session[:taskmaster] == true
  end

  helper_method :is_logged_in?
  helper_method :is_manager?
  helper_method :is_leader?
  helper_method :is_school?
  helper_method :is_taskmaster?

end
