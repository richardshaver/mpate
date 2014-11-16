class Manager < ActiveRecord::Base

	# Set up data validation for our forms

  	validates :user_name, presence: true, uniqueness: true
  	validates :password, length: { minimum: 4, maximum: 64}
  	validates :email, presence: true, uniqueness: true, email: true

end
