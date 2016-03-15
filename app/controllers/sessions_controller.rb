class SessionsController < ApplicationController
  def login
    #Login Form
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "You logged in successfully as #{authenticated_user.name}"
      flash[:color] = "valid"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid username or password"
      flash[:color]= "invalid"
      render "login"
    end
  end
end
