class ManagersController < ApplicationController

  # Set up the different controllers, so we can 
  # call them when we need to do specific actions

	def index
		@managers=Manager.all
	end

	def new
		@manager=Manager.new
	end

	def create
		@manager=Manager.new(model_params)
		if @manager.save
			redirect_to managers_path
		else
			render :new
		end
	end

  def show
    @manager = Manager.find(params[:id])
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])
    if @manager.update(model_params)
      redirect_to manager_path(@manager)
    else
      render :edit
    end
  end

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
