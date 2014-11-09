class Team < ActiveRecord::Base

	has_many :competitors

  	validates :number, presence: true
  	validates :color, presence: true


	def team_name
		color + " " + number.to_s
	end

	def total_score
		0 + score_one.to_i + score_two.to_i + score_three.to_i + score_four.to_i
	end

end
