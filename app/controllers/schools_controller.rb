class SchoolsController < ApplicationController
  require 'csv'
  include Resetter

  # Set up the different controllers, so we can 
  # call them when we need to do specific actions

  def index
  	@schools = School.all

    respond_to do |format|
      format.html do
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

  def new
  	@school = School.new
  end

  def create
  	@school = School.new(model_params)
  	if @school.save
  		redirect_to schools_path
  	else
  		render :new
  	end
  end

  def show
    @school = School.find(params[:id])
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update(model_params)
      redirect_to school_path(@school)
    else
      render :edit
    end
  end

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
