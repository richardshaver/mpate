class VolunteersController < ApplicationController
  require 'csv'
  include Resetter

  # Set up the different controllers, so we can 
  # call them when we need to do specific actions

  # Default view, if logged in, lists the volunteers in alphabetical order.
  # If not logged in, the view is a thank you for signing up (as got here from signup page)
	def index
		@volunteers=Volunteer.all.order("first_name ASC, last_name ASC")

    respond_to do |format|
      format.html do
        if is_logged_in?
          render "volunteers/index"
        else
          render "volunteers/thanks"
        end
      end
      format.csv do
        filename = "mpate-" + params[:controller] + "-" + Time.now.strftime("%m-%e-%Y")
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
	end

  # Display form to fill out for new volunteers to sign up
	def new
		@volunteer=Volunteer.new
    @tasks = Task.all.order(name: :asc)
	end

  # If signup information is correct, redisplay main index page
  # Otherwise, reshow the form to get corrections
	def create
		@volunteer=Volunteer.new(model_params)
		if @volunteer.save
			redirect_to volunteers_path
		else
      @tasks = Task.all.order(name: :asc)
			render :new
		end
	end

  # Show the information for specific volunteer
  def show
    @volunteer = Volunteer.find(params[:id])
  end

  # Show editing form for specific volunteer with pre-populated data
  def edit
    @volunteer = Volunteer.find(params[:id])
    @tasks = Task.all.order(name: :asc)
  end

  # If edited information is valid, redirect to volunteer index
  # Otherwise, re-show the form so we can get corrected information
  def update
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.update(model_params)
      redirect_to volunteer_path(@volunteer)
    else
      @tasks = Task.all.order(name: :asc)
      render :edit
    end
  end

  # When deleting a record, only delete the information for the volunteer selected
  def destroy
  	@volunteer = Volunteer.find(params[:id])
  	@volunteer.destroy
  	redirect_to volunteers_path
  end

  # List the only information allowed to be passed, to aid in security

	def model_params
		params.require(:volunteer).permit(
			:msu_id,
      :first_name,
      :last_name,
      :email,
      :phone,
   		:ref_instructor,
      :task_id
			)
	end
end
