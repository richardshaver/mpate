class Volunteer < ActiveRecord::Base

	belongs_to :task
	
	def full_name
		first_name + " " + last_name
	end

end
