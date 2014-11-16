class Task < ActiveRecord::Base

	# Each task can be assigned to multiple volunteers
	
	has_many :volunteers

	# Set up data validation for our forms

  	validates :name, presence: true

end
