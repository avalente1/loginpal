class UsersController < ApplicationController

  def new
  end

  def create
    s = Site.new
    s.company = params[:company]
    s.site = params[:site]
    s.username = params[:username]
    s.pwhint = params[:pwhint]
    s.save

    redirect_to sites_url
  end

  def index
    @s = Site.all

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @s }
    end
  end

  def show
    redirect_to sites_url
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
