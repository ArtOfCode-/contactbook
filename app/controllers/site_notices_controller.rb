class SiteNoticesController < ApplicationController
  before_filter :verify_admin
  before_action :set_site_notice, :only => [:edit, :update, :destroy]

  def new
    @site_notice = SiteNotice.new
  end

  def create
    @site_notice = SiteNotice.new(site_notice_params)
    @site_notice.created_by = @current_user.id
    if @site_notice.save
      flash[:notice] = "The notice was successfully created."
      flash[:color] = "valid"
      redirect_to action: :index
    else
      render :new
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
      render :edit
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
