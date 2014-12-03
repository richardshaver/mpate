class ManagersController < ApplicationController
  require 'csv'

  # Set up the different controllers, so we can 
  # call them when we need to do specific actions

  # List the managers in the system as the default page
	def index
		@managers=Manager.all

    respond_to do |format|
      format.html
      format.csv do
        filename = "mpate-" + params[:controller] + "-" + Time.now.strftime("%m-%e-%Y")
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
	end

  # Render the form to fill out when we want to add a new manager
	def new
		@manager=Manager.new
	end

  # If form correctly filled out, add new manager to database and redisplay list of managers
  # Otherwise redisplay form so user can make corrections to errors
	def create
		@manager=Manager.new(model_params)
		if @manager.save
			redirect_to managers_path
		else
			render :new
		end
	end

  # Find correct information when we want to see specific manager data
  def show
    @manager = Manager.find(params[:id])
  end

  # Prepopulate the editing form with correct data
  def edit
    @manager = Manager.find(params[:id])
  end

  # If editing successful, update record and redisplay list of managers
  # Otherwise, redisplay form so we can get corrections 
  def update
    @manager = Manager.find(params[:id])
    if @manager.update(model_params)
      redirect_to manager_path(@manager)
    else
      render :edit
    end
  end

  # When we want to delete a record, delete the correct data
  def destroy
  	@manager = Manager.find(params[:id])
  	@manager.destroy
  	redirect_to managers_path
  end

  # List the only information allowed to be passed, to aid in security

	def model_params
		params.require(:manager).permit(
	        :user_name,
            :password,
            :email,
 			)
	end

end
