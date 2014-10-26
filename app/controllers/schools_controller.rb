class SchoolsController < ApplicationController
  def index
  	@schools = School.all
  end

  def new
  	@school = School.new
  end

  def create
  	@school = School.new(model_params)
  	if @school.save
  		redirect_to schools_path
  	else
  		render :new
  	end
  end

  def show
    @school = School.find(params[:id])
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update(model_params)
      redirect_to school_path(@school)
    else
      render :edit
    end
  end

  def destroy
  	@school = School.find(params[:id])
  	@school.destroy
  	redirect_to schools_path
  end

  def model_params
  	params.require(:school).permit(
  		:school_name,
  		:username,
  		:password,
  		:address_line_1,
  		:address_line_2,
  		:city,
  		:state,
  		:zip,
  		:phone,
  		:teachers_attending
  	)
  end
end
