class LeadersController < ApplicationController
	def index
		@leaders=Leader.all
	end

	def new
		@leader=Leader.new
	end

	def create
		@leader=Leader.new(model_params)
		if @leader.save
			redirect_to leaders_path
		else
			render :new
		end
	end

  def show
    @leader = Leader.find(params[:id])
  end

  def edit
    @leader = Leader.find(params[:id])
  end

  def update
    @leader = Leader.find(params[:id])
    if @leader.update(model_params)
      redirect_to leader_path(@leader)
    else
      render :edit
    end
  end

  def destroy
  	@leader = Leader.find(params[:id])
  	@leader.destroy
  	redirect_to leaders_path
  end

	def model_params
		params.require(:leader).permit(
			:first_name,
			:last_name,
			:user_name,
			:password,
			:room,
			:security_level
			)
	end

end