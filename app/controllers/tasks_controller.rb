class TasksController < ApplicationController
	def index
		@tasks=Task.all
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

	def model_params
		params.require(:task).permit(
			:name
			)
	end
end
