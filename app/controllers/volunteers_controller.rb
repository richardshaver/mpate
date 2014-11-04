class VolunteersController < ApplicationController

	def index
		@volunteers=Volunteer.all
	end

	def new
		@volunteer=Volunteer.new
    @tasks = Task.all.order(name: :asc)
	end

	def create
		@volunteer=Volunteer.new(model_params)
		if @volunteer.save
			redirect_to volunteers_path
		else
      @tasks = Task.all.order(name: :asc)
			render :new
		end
	end

  def show
    @volunteer = Volunteer.find(params[:id])
  end

  def edit
    @volunteer = Volunteer.find(params[:id])
    @tasks = Task.all.order(name: :asc)
  end

  def update
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.update(model_params)
      redirect_to volunteer_path(@volunteer)
    else
      @tasks = Task.all.order(name: :asc)
      render :edit
    end
  end

  def destroy
  	@volunteer = Volunteer.find(params[:id])
  	@volunteer.destroy
  	redirect_to volunteers_path
  end

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
