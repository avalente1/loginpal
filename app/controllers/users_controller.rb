class UsersController < ApplicationController
  before_action :user_must_be_signed_in, except: [:new, :create]
  before_action :find_user, only: [:update, :destroy, :show, :edit]
  before_action :current_user_must_be_user, only: [:update, :destroy, :show, :edit]

  def user_must_be_signed_in
    unless current_user.present?
      flash[:info] = "Please sign in or sign up!"
      redirect_to new_session_url
    end
  end
  def find_user
    @user = User.find_by(id: current_user.id)
  end
  def current_user_must_be_user
    if @user != current_user
      redirect_to new_session_url, :notice => "You must be logged in."
    end
  end
  def create
    @user = User.new
    @user.email = params[:email].downcase
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
      # email = UserMailer.welcome
      # email.deliver
      # reset_session
      # session[:user_id] = @user.id
      redirect_to sites_url, notice: "Signed up successfully. Download our chrome extension by clicking the link above."
    else
      flash[:error] = "Email address already taken. Please sign up with a different email"
      redirect_to :back
    end
  end
  def show
    @sites = current_user.sites
    respond_to do |format|
      format.html { render 'show' }
      format.json { render json: @s }
    end
  end
  def edit
    @sites = current_user.sites
  end
  def update
    @user.email = params[:email].downcase
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_url(params[:id]), notice: "Updated account successfully"
    else
      flash.now[:error] = "Something went wrong. Please try again."
      render 'new'
    end
  end
  def destroy
    @user.destroy
    reset_session
    redirect_to home_url
  end
end
