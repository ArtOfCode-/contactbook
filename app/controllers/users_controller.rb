class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_action :verify_admin, :only => [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_confirmed = false
    @user.confirmation_token = Digest::SHA2.new(256).hexdigest("#{@user.created_at}#{@user.username}")
    if @user.save
      flash[:notice] = "You signed up successfully. You have been sent a confirmation email - click the link in it to confirm your account."
      flash[:color] = "valid"
    else
      flash[:notice] = "Something's not right - check your details and try again."
      flash[:color] = "invalid"
    end
    render 'new'
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :confirmation)
  end
end
