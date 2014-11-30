class School < ActiveRecord::Base

	# Each school will have several students
	
	has_many :competitors, dependent: :destroy

	# Set up data validation for our forms

 	validates :user_name, presence: true, uniqueness: true, if: :school_password_required
  validates :password, presence: true, length: { minimum: 4, maximum: 64}, if: :school_password_required
  validates :school_name, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def school_password_required
    Setting.find_by(key: "require_school_password").value == "yes"
  end
end
