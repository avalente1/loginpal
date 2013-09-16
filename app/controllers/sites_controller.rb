class SitesController < ApplicationController
  before_action :user_must_be_signed_in, except: [:home]
  before_action :find_site, only: [:destroy]
  before_action :find_sites, only: [:index, :edit]
  before_action :current_user_must_own_site, only: [:destroy]
  before_action :current_user_must_own_sites, only: [:index]
  def home
     render :layout => 'home.html.erb'
  end
  def user_must_be_signed_in
    unless current_user.present?
      redirect_to home_url
    end
  end
  def find_site
    @site = Site.find(params[:id])
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
    @site = Site.new(sites_params)
    @site.user_id = current_user.id
    respond_to do |format|
      if @site.save
        format.html {redirect_to sites_url, notice: "Succesfully added a website!" }
        format.json { render action: 'index', status: :created, location: @site }
        format.js
      else
        flash.now[:error] = "Please fill in all fields"
        format.html { render 'index' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
  def index
    @site = Site.new
    @sites_sort = @sites.sort_by{ |site| site[:company].titleize} #TODO sort_by usage or times visited site, favorites, etc. (High, Med, Low usage)
    @sites_decrypted = Hash.new({})
    @sites_decrypted["sites"] = Hash.new({})
    @sites_sort.each do |site|
      @sites_decrypted["sites"][site.company] = Hash.new({})
      # @sites_decrypted["sites"][site.company]["id"] = site.id
      @sites_decrypted["sites"][site.company]["favicon"] = site.favicon
      @sites_decrypted["sites"][site.company]["site"] = site.site
      @sites_decrypted["sites"][site.company]["company"] = site.company
      @sites_decrypted["sites"][site.company]["username"] = site.username_sb.decrypt(ENV['SB_DECRYPT'])
      @sites_decrypted["sites"][site.company]["pwhint"] = site.pwhint_sb.decrypt(ENV['SB_DECRYPT'])
    end
    @typeahead_array = Array.new
    @typeahead = Typeaheadtopsite.all.each{|t| @typeahead_array << t.company }

    @username_unique_array = Array.new
    @username_unique = current_user.sites.select("username_sb, username_sb_key, username_sb_iv")
    @username_unique.each{|u| @username_unique_array << u.username_sb.decrypt(ENV['SB_DECRYPT']) }
    @username_unique_array_distinct = @username_unique_array.uniq

    # Typeaheadtopsite.all.each{|t| t.save } # Save all typeaheadtopsites to make the favicon run
    # User.all.each{|t| t.save }
    ####### ARRAY of hashes #########
    # @sites_decrypted = Array.new
    # @sites_sort.each do |site|
    #   @sites_decrypted << {site.id => {company: site.company, username: site.username_sb.decrypt(ENV['SB_DECRYPT']), pwhint: site.pwhint_sb.decrypt(ENV['SB_DECRYPT'])}}
    # end
    # @sites_sort.each{|site| {site.id => {company: site.company, username: site.username_sb.decrypt(ENV['SB_DECRYPT']), pwhint: site.pwhint_sb.decrypt(ENV['SB_DECRYPT'])}}}
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @sites_decrypted.to_json }
      format.js
      # format.xml { render xml: @sites_decrypted }
    end
  end
  def edit
    @site = Site.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  def destroy
    @site.destroy
    respond_to do |format|
      flash.now[:notice] = "Succesfully deleted"
      format.html { redirect_to sites_url }
      format.json { head :no_content }
      format.js
    end
  end
  def update
    @site = Site.find_by(id: params[:id])
    @site.company = params[:company]
    @site.username_sb = params[:username_sb]
    @site.pwhint_sb = params[:pwhint_sb]
    @site.save
    respond_to do |format|
      format.js
    end
  end
  def sites_params
    params.require(:site).permit(:company, :username_sb, :pwhint_sb)
  end
end
