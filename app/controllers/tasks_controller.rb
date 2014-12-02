class TasksController < ApplicationController
  require 'csv'
  include Resetter

	# Set up the different controllers, so we can 
	# call them when we need to do specific actions

	def index
		@tasks=Task.all.order("name ASC")

	    respond_to do |format|
	      format.html
	      format.csv do
	        filename = "mpate-" + params[:controller] + "-" + Time.now.strftime("%m-%e-%Y")
	        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
	        headers['Content-Type'] ||= 'text/csv'
	      end
	    end
	end

	def new
		@task=Task.new
	end

	def create
		@task=Task.new(model_params)
		if @task.save
			redirect_to tasks_path
		else
			render :new
		end
	end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(model_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
  	@task = Task.find(params[:id])
  	@task.destroy
  	redirect_to tasks_path
  end

	# List the only information allowed to be passed, to aid in security

	def model_params
		params.require(:task).permit(
		  :name
		)
	end
end
