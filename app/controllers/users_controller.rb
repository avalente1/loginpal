class UsersController < ApplicationController

  def new
  end

  def create
    @s = Site.all
    u = User.new
    u.email = params["email"]
    u.password = params["password"]
    u.save

    redirect_to user_url(params[:id])
  end

  def index
    @s = Site.all
    @u = User.all

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @s }
    end
  end

  def show
    @s = Site.all
    @u = params[:id]
  end

  def edit
    @s = Site.all
  end

  def update
    s = Site.find(params[:cell])
    s.company = params[:company]
    s.site = params[:site]
    s.username = params[:username]
    s.pwhint = params[:pwhint]
    s.save
    redirect_to sites_url, notice: "You have successfully updated your account"
  end

  def destroy
    s = Site.find(params[:id])
    s.destroy
    redirect_to sites_url
  end

end
