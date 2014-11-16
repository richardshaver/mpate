class SessionsController < ApplicationController
  def new
  end

  # Get the login information for the session to determine user type
  # This sets the security level of the user
  # to determine what they will see displayed on screen

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

      # Room leaders may be set as taskmaster if they also have
      # the ability to create and edit the tasks
      # If they are not a taskmaster, then that room leader
      # will not be able to manage the tasks

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

  # When session is over, we need to reset the login information
  
  def destroy
    session[:user] = nil
    session[:type] = nil
    session[:taskmaster] = nil
    redirect_to root_path
  end
end
