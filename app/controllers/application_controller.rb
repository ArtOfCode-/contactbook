class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user
  after_filter :clear_notice

  protected
  def authenticate_user
    if session[:user_id]
       # set current user object to @current_user object variable
      @current_user = User.find session[:user_id]
      return true
    else
      flash[:notice] = "You must log in first."
      flash[:color] = "invalid"
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

  def clear_notice
    flash[:notice] = nil
    flash[:color] = nil
    flash[:admin_notice] = nil
  end

  def verify_admin
    auth = authenticate_user
    if auth
      if !@current_user.is_admin
        flash[:notice] = "You must be an administrator to access that page."
        flash[:color] = "invalid"
        redirect_to root_path
        return
      else
        flash[:admin_notice] = true
      end
    end
  end
end
