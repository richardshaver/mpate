class Team < ActiveRecord::Base

	# Each team will consist of multiple competitors

	has_many :competitors

	# Set up data validation for our forms

  	validates :number, presence: true
  	validates :color, presence: true

  	# Set up a way to display the entire team name
  	# which consists of a color and a number
	def team_name
		color + " " + number.to_s
	end

	# Calculate total score for the team
	def total_score
		0 + score_one.to_i + score_two.to_i + score_three.to_i + score_four.to_i
	end

end
