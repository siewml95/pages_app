class SessionsController < ApplicationController


  def new
      if(logged_in?)
        user = User.find(session[:user_id])
      redirect_to user_path(user)
    
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully log in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was nothing wrong with your login information"
      render 'new'
    end


  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path

  end
end