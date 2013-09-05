class PasswordResetsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      user.send_password_reset
      render 'sites/home', :layout => 'home.html.erb', :notice => "Please check your email to reset your password."
    else
      render 'sites/home', :layout => 'home.html.erb', notice: "We're sorry, we could not find an account with that email. Please try again."
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_at < 8.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired"
    elsif @user.update_attributes(user_params)
      redirect_to home_url, notice: "Password has been reset!"
      # TODO login new user!
    else
      render "edit"
    end
  end
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
