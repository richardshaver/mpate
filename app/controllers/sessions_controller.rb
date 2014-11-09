class SessionsController < ApplicationController
  def new
  end

  def create
  	if user = Manager.find_by(user_name: params[:user_name])
  		@user = user
  		@type = "manager"
  	elsif user = Leader.find_by(user_name: params[:user_name])
  		@user = user
  		@type = "leader"
  	elsif user = School.find_by(user_name: params[:user_name])
  		@user = user
  		@type = "school"
  	end

  	if @user && @user.password == params[:password]
  		session[:user] = @user.id
  		session[:type] = @type

  		if @type == "leader" && @user.security_level == "taskmaster"
  			session[:taskmaster] = true
  		else
  			session[:taskmaster] = false
  		end

  		redirect_to root_path
  	else
  		render :new
  	end
  end

  def destroy
    session[:user] = nil
    session[:type] = nil
    session[:taskmaster] = nil
    redirect_to root_path
  end
end
