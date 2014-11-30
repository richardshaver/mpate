class TeamsController < ApplicationController
  require 'csv'
  include Resetter

	# Set up the different controllers, so we can 
	# call them when we need to do specific actions

	def index
		if params[:filter]
			@active_btn = params[:filter]
			leader = Leader.find(session[:user])

			if params[:filter] == "room_1"
				@teams = Team.where(room_1: leader.room).order(color: :asc).order(number: :asc)
			elsif params[:filter] == "room_2"
				@teams = Team.where(room_2: leader.room).order(color: :asc).order(number: :asc)
			elsif params[:filter] == "room_3"
				@teams = Team.where(room_3: leader.room).order(color: :asc).order(number: :asc)
			elsif params[:filter] == "room_4"
				@teams = Team.where(room_4: leader.room).order(color: :asc).order(number: :asc)
			else
				@teams=Team.all.order(color: :asc).order(number: :asc)
			end
		else
			@teams=Team.all.order(color: :asc).order(number: :asc)
     		@active_btn = ""
		end

		@leaders = Leader.all.order(room: :asc)
		if Team.count > 0
			@max_team_number = Team.order(number: :desc).first.number
		else
			@max_team_number = 0
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

	def setup
	  	colors = ["Black", "Blue", "Green", "Red", "Yellow", "Orange"]

		colors.each do |c|
			25.times do |i|
				n = i+1
				t = Team.new
				t.color = c
				t.number = n
				if Team.where(color: c).where(number: n).empty?
					t.save!
				end
			end
		end
		redirect_to teams_path
	end

	def assign_room
		Team.update_all({room_1: params[:room_1]}, {number: params[:number]}) unless params[:room_1].blank?
		Team.update_all({room_2: params[:room_2]}, {number: params[:number]}) unless params[:room_2].blank?
		Team.update_all({room_3: params[:room_3]}, {number: params[:number]}) unless params[:room_3].blank?
		Team.update_all({room_4: params[:room_4]}, {number: params[:number]}) unless params[:room_4].blank?
		redirect_to teams_path, notice: "Rooms Updated"
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
