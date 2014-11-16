class Leader < ActiveRecord::Base

	# Set up data validation for our forms

  	validates :first_name, presence: true
  	validates :last_name, presence: true
  	validates :user_name, presence: true, uniqueness: true
  	validates :password, presence: true, length: { minimum: 4, maximum: 64}
  	validates :room, presence: true

  	# Create a way to display both names with single variable
  	
	def full_name
		first_name + " " + last_name
	end

end
