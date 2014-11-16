class TeamsController < ApplicationController

	# Set up the different controllers, so we can 
	# call them when we need to do specific actions

	def index
		@teams=Team.all
	end

	def new
		@team=Team.new
	end

	def create
		@team=Team.new(model_params)
		if @team.save
			redirect_to teams_path
		else
			render :new
		end
	end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(model_params)
      redirect_to team_path(@team)
    else
      render :edit
    end
  end

  def destroy
  	@team = Team.find(params[:id])
  	@team.destroy
  	redirect_to teams_path
  end

  def results
  	@teams = Team.all
  end

	# List the only information allowed to be passed, to aid in security

	def model_params
		params.require(:team).permit(
			:number,
			:color,
			:score_one,
			:score_two,
			:score_three,
			:score_four
			)
	end
end
