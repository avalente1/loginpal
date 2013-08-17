class SitesController < ApplicationController
  before_action :user_must_be_signed_in
  before_action :find_site, only: [:update, :destroy]
  before_action :find_sites, only: [:index, :edit, :update_all_sites]
  before_action :current_user_must_own_site, only: [:update, :destroy]
  before_action :current_user_must_own_sites, only: [:index, :edit]

  def json
  end

  def user_must_be_signed_in
    unless current_user.present?
      flash[:info] = "Please sign in or sign up!"
      redirect_to new_session_url
    end
  end

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

  def create
    @site = Site.new
    @site.company = params[:company]
    @site.username = params[:username]
    @site.pwhint = params[:pwhint]
    @site.user_id = current_user.id
    @site.favicon = "https://plus.google.com/_/favicon?domain=www.#{@site.company.delete(" ")}.com"
    @site.site = "http://www.#{@site.company.delete(" ")}.com"

    if @site.save
      redirect_to sites_url, notice: "Succesfully added a website!"
    else
      flash[:error] = "Please fill in all fields"
      render 'index'
    end
  end

  def index
    @a = Array.new
    @sites.each{|s| @a << s}

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @a }
      format.xml { render xml: @a }
    end
  end

  def edit
  end

  def destroy
    @site.destroy
    flash[:notice] = "Succesfully deleted"
    redirect_to sites_url
  end

  def update_all_sites
    if Site.update(params[:site].keys, params[:site].values)
      flash[:notice] = 'Sites successfully updated.'
      redirect_to sites_url
    else
      flash[:error] = "Updates not saved. Please try again."   # Need to render edit if not saved successfully and dispplay an error
      render 'edit'
    end
  end

end
      # Old code
      # Site.update(params[:site].keys, params[:site].values)
      # flash[:notice] = 'Sites successfully updated.'
      # redirect_to sites_url
