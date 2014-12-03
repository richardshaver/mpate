class SchoolsController < ApplicationController
  require 'csv'
  include Resetter

  # Set up the different controllers, so we can 
  # call them when we need to do specific actions

  # Default display will list all schools in ascending order
  def index
  	@schools = School.all.order("school_name ASC")

    respond_to do |format|
      format.html do
        # If school is logged in, we render the main page.
        # Otherwise, they were not logged in, then school signed up on open page. Display thanks for signing up
        if is_logged_in?
          render "schools/index"
        else
          render "schools/thanks"
        end
      end
      format.csv do
        filename = "mpate-" + params[:controller] + "-" + Time.now.strftime("%m-%e-%Y")
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # Display form for new school to sign up
  def new
  	@school = School.new
  end

  # If new school signup form has valid information, add to database and re-render page
  # Otherwise, redisplay form so we can get corrections
  def create
  	@school = School.new(model_params)
  	if @school.save
  		redirect_to schools_path
  	else
  		render :new
  	end
  end

  # Show correct information when we want to see data on a specific school
  def show
    @school = School.find(params[:id])
  end

  # Prepopulate editing form when we want to make changes to school data
  def edit
    @school = School.find(params[:id])
  end

  # If editing is successful, save changes and return to main page
  # Otherwise, return to form to get corrections
  def update
    @school = School.find(params[:id])
    if @school.update(model_params)
      redirect_to school_path(@school)
    else
      render :edit
    end
  end

  # Ensure we delete correct school when we want to remove it from database
  def destroy
  	@school = School.find(params[:id])
  	@school.destroy
  	redirect_to schools_path
  end

  # List the only information allowed to be passed, to aid in security

  def model_params
  	params.require(:school).permit(
  		:school_name,
  		:user_name,
  		:password,
  		:address_line_1,
  		:address_line_2,
  		:city,
  		:state,
  		:zip,
  		:phone,
  		:teachers_attending
  	)
  end
end
