module Resetter
	extend ActiveSupport::Concern

	def reset
		if is_manager?
		    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{params[:controller]}")
		    redirect_to competitors_path, notice: "Reset #{params[:controller].capitalize}"
	   	else
	   		redirect_to competitors_path
		end
	end
end