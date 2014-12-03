class TasksController < ApplicationController
  require 'csv'
  include Resetter

	# Set up the different controllers, so we can 
	# call them when we need to do specific actions

	# Default page shows current tasks in alphabetical order
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

	# Display form to fill out when we want to create a new task
	def new
		@task=Task.new
	end

	# If new task form successfully filled out, add new task and return to task listing
	# Otherwise redisplay form to get corrections
	def create
		@task=Task.new(model_params)
		if @task.save
			redirect_to tasks_path
		else
			render :new
		end
	end

	# Display correct information when we want to see data of specific task
	def show
		@task = Task.find(params[:id])
	end

	# Prepopulate editing form
	def edit
		@task = Task.find(params[:id])
	end

	# If editing form correct, update the task and return to task listing
	# Otherwise, return to form for corrections
	def update
		@task = Task.find(params[:id])
		if @task.update(model_params)
			redirect_to tasks_path
		else
			render :edit
		end
	end

	# Delete correct record when we want to remove a task from database
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
