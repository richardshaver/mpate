class MainController < ApplicationController
  def index
  	if is_logged_in? && is_school?
  		redirect_to school_path(session[:user])
  	end
  end
end
