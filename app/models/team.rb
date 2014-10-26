class Team < ActiveRecord::Base

	def team_name
		color + " " + number.to_s
	end

end
