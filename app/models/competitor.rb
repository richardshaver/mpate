class Competitor < ActiveRecord::Base

	belongs_to :school
	belongs_to :team

	validates_presence_of :school
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, allow_blank: true, email: true, uniqueness: true
 	validates :grade, presence: true
 	validates :address_line_1, presence: true
 	validates :city, presence: true
 	validates :state, presence: true
 	validates :zip, presence: true

	def full_name
		first_name + " " + last_name
	end

end
