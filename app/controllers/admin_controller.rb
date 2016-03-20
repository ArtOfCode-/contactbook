class AdminController < ApplicationController
  def index
  end

  private
    def verify_admin
      if @current_user.nil? or !@current_user.is_admin
        redirect_to root_path
        return
      end
    end
end
