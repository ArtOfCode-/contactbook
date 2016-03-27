class SiteNoticesController < ApplicationController
  before_filter :verify_admin
  before_action :set_site_notice, :only => [:edit, :update, :destroy]

  def new
    @site_notice = SiteNotice.new
  end

  def create
    @site_notice = SiteNotice.new(site_notice_params)
    if @site_notice.save
      flash[:notice] = "The notice was successfully created."
      flash[:color] = "valid"
      redirect_to action: :index
    else
      flash[:notice] = "The notice could not be created - please try again."
      flash[:color] = "invalid"
      redirect_to action: :new
    end
  end

  def edit
  end

  def update
    if @site_notice.update(site_notice_params)
      flash[:notice] = "The notice was successfully updated."
      flash[:color] = "valid"
      redirect_to action: :index
    else
      flash[:notice] = "The notice could not be updated - please try again."
      flash[:color] = "invalid"
      redirect_to action: :index
    end
  end

  def destroy
    @site_notice.destroy
    flash[:notice] = "The notice was successfully deleted."
    flash[:color] = "valid"
    redirect_to action: :index
  end

  def index
    @site_notices = SiteNotice.all
  end

  private
    def set_site_notice
      @site_notice = SiteNotice.find(params[:id])
    end

    def site_notice_params
      params.require(:site_notice).permit(:text)
    end
end
