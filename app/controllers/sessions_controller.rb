class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.email}"
      redirect_to sites_url
    else
      flash.now[:error] = "Invalid email and password combination.  Please try again or sign up!"
      render 'sites/home', :layout => 'home.html.erb'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Signed out successfully."
    redirect_to home_url
  end

end
