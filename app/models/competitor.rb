class Competitor < ActiveRecord::Base

	belongs_to :school

	def full_name
		first_name + " " + last_name
	end

end
