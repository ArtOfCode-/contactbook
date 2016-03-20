class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully."
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
