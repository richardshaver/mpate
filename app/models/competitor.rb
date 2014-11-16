class Competitor < ActiveRecord::Base

	# Each competitor can be a student of a school 
	# as well as a member of a team

	belongs_to :school
	belongs_to :team

	# Set up data validation for our forms

	validates_presence_of :school
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, allow_blank: true, email: true, uniqueness: true
 	validates :grade, presence: true
 	validates :address_line_1, presence: true
 	validates :city, presence: true
 	validates :state, presence: true
 	validates :zip, presence: true

 	# This creates a way to display both names with a single variable
 	
	def full_name
		first_name + " " + last_name
	end

end
