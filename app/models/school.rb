class School < ActiveRecord::Base

	# Each school will have several students
	
	has_many :competitors

	# Set up data validation for our forms

 	validates :user_name, presence: true, uniqueness: true
  	validates :password, presence: true, length: { minimum: 4, maximum: 64}
  	validates :school_name, presence: true
  	validates :address_line_1, presence: true
  	validates :city, presence: true
  	validates :state, presence: true
  	validates :zip, presence: true

end
