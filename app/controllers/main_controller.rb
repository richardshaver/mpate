class MainController < ApplicationController

# If logged in as school, go directly to school display as that is their only access
	def index
		if is_logged_in? && is_school?
			redirect_to school_path(session[:user])
		end
	end
end
