class UsersController < ApplicationController
  before_action :find_user, only: [:update, :destroy, :show, :edit]
  before_action :current_user_must_be_user, only: [:update, :destroy, :show, :edit]

  def find_user
    @user = User.find_by(id: current_user.id)
  end

  def current_user_must_be_user
    if @user != current_user
      redirect_to sites_url, :notice => "Not authorized for that."
    end
  end

  def new
  end

  def create
    @user = User.new
    @user.email = params[:email].downcase
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to user_url(params[:id]), notice: "Signed up successfully"
    else
      flash.now[:error] = "Something went wrong. Please try again."
      render 'new'
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
    redirect_to new_user_url
  end

end
