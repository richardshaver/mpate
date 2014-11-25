class Volunteer < ActiveRecord::Base

	belongs_to :task

	# Set up data validation for our forms

  	validates :msu_id, presence: true, uniqueness: true
  	validates :first_name, presence: true
  	validates :last_name, presence: true
  	validates :email, presence: true, uniqueness: true, email: true
	
  	# Set up a way to display both names with single variable
  	
	def full_name
		first_name + " " + last_name
	end

end
