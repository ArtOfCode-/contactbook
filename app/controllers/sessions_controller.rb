class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:dek] = derive_dek(authorized_user)
      flash[:notice] = "You logged in successfully as #{authorized_user.username}"
      flash[:color] = "valid"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid username or password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    session[:dek] = nil
    if flash[:preserve_notice].nil? || flash[:preserve_notice] == false
      flash[:notice] = "You are now logged out."
      flash[:color] = "valid"
    else
      flash[:preserve_notice] = false
    end
    redirect_to :action => 'login'
  end

  private
    def encrypt_password(password, salt)
      BCrypt::Engine.cost = 13
      return BCrypt::Engine.hash_secret(password, salt)
    end

    def derive_dek(user)
      encrypted = encrypt_password(params[:login_password], user.salt)
      return Digest::SHA2.new(256).hexdigest("#{params[:login_password]}#{encrypted}")
    end
end
