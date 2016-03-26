class DynamicRoutesController < ApplicationController
  before_filter :check_login_status, :only => [:root]

  def root
    if !@current_user.nil?
      redirect_to contacts_path
    else
      redirect_to url_for(:controller => :help_about, :action => :whats_this)
    end
  end
end
