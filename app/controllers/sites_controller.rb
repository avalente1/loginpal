class SitesController < ApplicationController
  before_action :find_site, only: [:update, :destroy]
  before_action :find_sites, only: [:index, :edit]
  before_action :current_user_must_own_site, only: [:update, :destroy]
  before_action :current_user_must_own_sites, only: [:index, :edit]

  def find_site
    @site = Site.find(params[:site_id])
  end

  def find_sites
    @sites = current_user.sites
  end

  def current_user_must_own_site
    if @site.user != current_user
       redirect_to sites_url, :notice => "Please sign in."
    end
  end

  def current_user_must_own_sites
    @sites.each do |s|
      if s.user != current_user
       redirect_to sites_url, :notice => "Please sign in."
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
    @site.company = params[:company]
    @site.site = params[:site]
    @site.username = params[:username]
    @site.pwhint = params[:pwhint]
    @site.user_id = current_user.id
    @site.save
    redirect_to sites_url, notice: "You have successfully updated your account"
  end

  def destroy
    @site.destroy
    flash[:notice] = "Succesfully deleted"
    redirect_to sites_url
  end

end
