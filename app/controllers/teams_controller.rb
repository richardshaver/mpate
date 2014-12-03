class TeamsController < ApplicationController
  require 'csv'
  include Resetter

	# Set up the different controllers, so we can 
	# call them when we need to do specific actions

	# Default view lists teams. But if room leader, only show teams that are assigned to your room
	# This list is filtered by round number (each room is used in a different round)
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

	# Show the form to fill out for creating a new team. 
	# Valid room numbers are those in use by room leaders.
	def new
		@team=Team.new
		@leaders = Leader.all.order(room: :asc)
	end

	# If form correctly filled out, create the team and redirect to display teams.
	# Otherwise, re-show the form so we can get corrections
	def create
		@team=Team.new(model_params)
		if @team.save
			redirect_to teams_path
		else
			@leaders = Leader.all.order(room: :asc)
			render :new
		end
	end

	# Show the information for the specific team selected
	def show
		@team = Team.find(params[:id])
	end

	# Show the form for editing, with prepopulated information
	def edit
	    @team = Team.find(params[:id])
		@leaders = Leader.all.order(room: :asc)
	end

	# If edit form correctly filled out, update the team (with message about updated scores if room leader)
	# Otherwise, reshow the form tp get corrections
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

  	# When deleting a team, delete the correct team
	def destroy
		@team = Team.find(params[:id])
 		@team.destroy
 		redirect_to teams_path
	end

	# When displaying the results, we want to display the results for all teams
	def results
 		@teams = Team.all
	end

	# Setting up new teams, from #1 to #25, in all six colors. 
	# It will not set up the team if it already exists.
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

	# Assign the four rooms to a given team
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
