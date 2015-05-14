class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if User.is_first_user?
      redirect_to admin_url #this creates a temporary administrator
    else
      if user and user.authenticate(params[:password]) #this checks the user password for authenticity
        #logs the user in
        session[:user_id] = user.id #logs the user into the session
        redirect_to admin_url #this logged-in user is an administrator
      else
        session[:user_id] = 0
        redirect_to login_url, alert: "Invalid username/password combination"
      end
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
    
end
