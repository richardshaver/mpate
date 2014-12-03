class LeadersController < ApplicationController
  require 'csv'
  include Resetter

  	# Dispay room leaders in ascending order for easy reference
	def index
		@leaders=Leader.all.order("first_name ASC, last_name ASC")

	    respond_to do |format|
	      format.html
	      format.csv do
	        filename = "mpate-" + params[:controller] + "-" + Time.now.strftime("%m-%e-%Y")
	        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
	        headers['Content-Type'] ||= 'text/csv'
	      end
	    end
	end

	# Set up the different controllers, so we can 
	# call them when we need to do specific actions

	# Render the form to fill out when we want to create a new leader
	def new
		@leader=Leader.new
	end

	# If form successfully filled out, add the leader to database and redirect to list of leader.
	# Otherwise, redisplay the form to fill out
	def create
		@leader=Leader.new(model_params)
		if @leader.save
			redirect_to leaders_path
		else
			render :new
		end
	end

	# Find correct information when displaying specific leader information
 	def show
 		@leader = Leader.find(params[:id])
 	end	

 	# Find correct information to populate the fields of the editing form
 	def edit
 		@leader = Leader.find(params[:id])
 	end

 	# If editing form correctly filled out, update the record and redirect to list of leaders
 	# Otherwise redisplay form for correcting
 	def update
 		@leader = Leader.find(params[:id])
 		if @leader.update(model_params)
 			redirect_to leader_path(@leader)
 		else
 			render :edit
 		end
 	end

 	# When we want to delete a record, find the correct record and delete it, then redisplay list of leaders
 	def destroy
 		@leader = Leader.find(params[:id])
 		@leader.destroy
 		redirect_to leaders_path
 	end

	# List the only information allowed to be passed, to aid in security

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
