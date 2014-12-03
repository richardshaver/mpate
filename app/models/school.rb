class School < ActiveRecord::Base

	# Each school will have several students
	
	has_many :competitors, dependent: :destroy

	# Set up data validation for our forms
  # Only require username and password if the system manager requires schools to log in

 	validates :user_name, presence: true, uniqueness: true, if: :school_password_required
  validates :password, presence: true, length: { minimum: 4, maximum: 64}, if: :school_password_required
  validates :school_name, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  # This checks if the schools need to log in to sign up competitors, or if it's open sign up
  def school_password_required
    Setting.find_by(key: "require_school_password").value == "yes"
  end
end
