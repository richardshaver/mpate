class MainController < ApplicationController
  def index

  	# If logged in as school, go directly to school display
  	# as that is their only access
  	
  	if is_logged_in? && is_school?
  		redirect_to school_path(session[:user])
  	end
  end
end
