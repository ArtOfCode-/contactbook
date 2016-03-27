class DynamicRoutesController < ApplicationController
  before_filter :check_login_status, :only => [:root]

  def root
    if !@current_user.nil?
      redirect_to contacts_path
    else
      redirect_to url_for(:controller => :sessions, :action => :home)
    end
  end
end
