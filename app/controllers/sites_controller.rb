class SitesController < ApplicationController
  before_action :find_sites
  before_action :current_user_must_own_sites

  def find_sites
    @sites = current_user.sites
  end

  def current_user_must_own_sites
    @sites.each do |s|
      if s.user != current_user
       redirect_to sites_url, :notice => "Not authorized for that."
      end
    end
  end

  def new
  end

  def create
    @site = Site.new
    @site.company = params[:company]
    @site.site = params[:site]
    @site.username = params[:username]
    @site.pwhint = params[:pwhint]
    @site.user_id = current_user.id

    if @site.save
      redirect_to sites_url, notice: "Succesfully added a website!"
    else
      flash[:error] = "Please fill in all fields"
      redirect_to sites_url
    end
  end

  def index
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @sites }
    end
  end

  def edit
  end

  def update
    s = Site.find(params[:cell])
    s.company = params[:company]
    s.site = params[:site]
    s.username = params[:username]
    s.pwhint = params[:pwhint]
    s.user_id = current_user.id
    s.save
    redirect_to sites_url, notice: "You have successfully updated your account"
  end

  def destroy
    s = Site.find_by_id(params[:site_id])
    s.destroy
    redirect_to sites_url
  end

end
