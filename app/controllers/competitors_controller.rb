class CompetitorsController < ApplicationController

	def index
		@competitors=Competitor.all
	end

	def new
		@competitor=Competitor.new
	end

	def create
		@competitor=Competitor.new(model_params)
		if @competitor.save
			redirect_to competitors_path
		else
			render :new
		end
	end

  def show
    @competitor = Competitor.find(params[:id])
  end

  def edit
    @competitor = Competitor.find(params[:id])
  end

  def update
    @competitor = Competitor.find(params[:id])
    if @competitor.update(model_params)
      redirect_to competitor_path(@competitor)
    else
      render :edit
    end
  end

  def destroy
  	@competitor = Competitor.find(params[:id])
  	@competitor.destroy
  	redirect_to competitors_path
  end


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
      		:email
 			)
	end

end
