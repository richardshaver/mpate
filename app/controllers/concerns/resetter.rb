module Resetter
	extend ActiveSupport::Concern

	# Choose redirect destinations based on current page. Page reloading
	def reset
		case params[:controller]
			when "competitors"
				redirect_destination = competitors_path
			when "leaders"
				redirect_destination = leaders_path
			when "schools"
				redirect_destination = schools_path
			when "tasks"
				redirect_destination = tasks_path
			when "teams"
				redirect_destination = teams_path
			when "volunteers"
				redirect_destination = volunteers_path
		end

		if is_manager?
		    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{params[:controller]}")
		    redirect_to redirect_destination, notice: "Reset #{params[:controller].capitalize}"
	   	else
	   		redirect_to redirect_destination
		end
	end
end