class AdminController < ApplicationController
  before_action :verify_admin

  def index
  end

  private
    def verify_admin
      if @current_user.nil? or !@current_user.is_admin
        flash[:notice] = "You must be an administrator to view that page."
        flash[:color] = "invalid"
        redirect_to root_path
        return
      else
        flash[:admin_notice] = true
      end
    end
end
