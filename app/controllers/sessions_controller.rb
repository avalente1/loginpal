class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.email}"
      redirect_to user_url(session[:user_id])
    else
      flash[:error] = "Invalid email address.  Please try again or sign up!"
      render 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Signed out successfully."
    redirect_to new_session_url
  end

end
