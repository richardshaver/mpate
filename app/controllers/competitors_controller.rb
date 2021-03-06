class CompetitorsController < ApplicationController
  require 'csv'
  include Resetter

  # Ensure schools and teams are referenced as we display the competitors data
  before_action :set_schools_and_teams, except: [:index, :show, :destroy]

  # Set up the different controllers, so we can 
  # call them when we need to do specific actions

  # Main index page for competitors, which lists them alphabetically by first name
	def index
		@competitors=Competitor.all.order("first_name ASC, last_name ASC")

    respond_to do |format|
      format.html do
        # If logged in as user, then it displays the list of competitors
        # If not, then we got here through open signup, and display thanks for signing up
        if is_logged_in?
          render "competitors/index"
        else
          render "competitors/thanks"
        end
      end
      format.csv do
        filename = "mpate-" + params[:controller] + "-" + Time.now.strftime("%m-%e-%Y")
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
	end

  # Add another controller method to render the badges CSV file for download.

  def badges
    @competitors=Competitor.all
    respond_to do |format|
      format.csv do
        filename = "competitor-badges-" + Time.now.strftime("%m-%e-%Y")
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # Renders the form for new competitors
	def new
		@competitor=Competitor.new
	end

  # If logged in as school, go directly to specific school infomation page
  # Otherwise we show the total list of competitors as only other way to see this page is to be 
  # logged in as a manager
  # This redirect is if form correctly filled out. If not, then we return to the form

	def create
		@competitor=Competitor.new(model_params)
		if @competitor.save
      if is_school?
        redirect_to school_path(session[:user])
      else
  			redirect_to competitors_path
      end
		else
			render :new
		end
	end

  # Used to find the information of a specific competitor when we want to see his information
  def show
    @competitor = Competitor.find(params[:id])
  end

  # Find the information of a specific competitor, so we can fill out the fields on the form when we go to edit
  def edit
    @competitor = Competitor.find(params[:id])
  end

  # If we got a successful form filled out, update the competitor. Otherwise, redirect to the form again
  def update
    @competitor = Competitor.find(params[:id])
    if @competitor.update(model_params)
      redirect_to competitor_path(@competitor)
    else
      render :edit
    end
  end

  # Find the correct competitor and remove from database (Called when we delete a record)
  def destroy
  	@competitor = Competitor.find(params[:id])
  	@competitor.destroy
  	redirect_to competitors_path
  end

  # This will find and display schools and teams in ascending order
  def set_schools_and_teams
    @schools = School.all.order(school_name: :asc)
    @teams = Team.all.order(:color, :number)
  end


  # List the only information allowed to be passed, to aid in security

	def model_params
		params.require(:competitor).permit(
      		:first_name,
      		:last_name,
      		:address_line_1,
      		:address_line_2,
      		:city,
      		:state,
      		:zip,
      		:grade,
      		:email,
          :school_id,
          :team_id
 			)
	end

end
