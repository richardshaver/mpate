class Volunteer < ActiveRecord::Base

	belongs_to :task

  	validates :msu_id, presence: true
  	validates :first_name, presence: true
  	validates :last_name, presence: true
  	validates :email, presence: true, uniqueness: true, email: true
	
	def full_name
		first_name + " " + last_name
	end

end
