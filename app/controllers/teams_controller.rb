class TeamsController < ApplicationController
  require 'csv'

	# Set up the different controllers, so we can 
	# call them when we need to do specific actions

	def index
		if params[:filter]
			@active_btn = params[:filter]
			leader = Leader.find(session[:user])

			if params[:filter] == "room_1"
				@teams = Team.where(room_1: leader.room)
			elsif params[:filter] == "room_2"
				@teams = Team.where(room_2: leader.room)
			elsif params[:filter] == "room_3"
				@teams = Team.where(room_3: leader.room)
			elsif params[:filter] == "room_4"
				@teams = Team.where(room_4: leader.room)
			else
				@teams=Team.all
			end
		else
			@teams=Team.all
     		@active_btn = ""
		end




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
		@team=Team.new
		@leaders = Leader.all.order(room: :asc)
	end

	def create
		@team=Team.new(model_params)
		if @team.save
			redirect_to teams_path
		else
			@leaders = Leader.all.order(room: :asc)
			render :new
		end
	end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
	@leaders = Leader.all.order(room: :asc)
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(model_params)
    	if params[:team][:filter]
    	  redirect_to teams_path(filter: params[:team][:filter]), notice: "Score Updated"
    	else
	      redirect_to team_path(@team)
        end
    else
	  @leaders = Leader.all.order(room: :asc)
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
			:score_four,
			:room_1,
			:room_2,
			:room_3,
			:room_4
			)
	end
end
