class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_action :verify_admin, :only => [:index]
  before_action :authenticate_user, :only => [:confirm]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_confirmed = false
    @user.confirmation_token = Digest::SHA2.new(256).hexdigest("#{@user.created_at}#{@user.username}#{Time.now}")
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

  def confirm
    if params[:token] == @current_user.confirmation_token
      if @current_user.updated_at > Time.now - 60.minutes
        @current_user.is_confirmed = true
        @current_user.confirmation_token = nil
        @current_user.save
        flash[:notice] = "Your account has been confirmed."
        flash[:color] = "valid"
      else
        flash[:notice] = "This confirmation token has expired; a new token has been emailed to you."
        flash[:color] = "invalid"
        @current_user.confirmation_token = Digest::SHA2.new(256).hexdigest("#{@user.created_at}#{@user.username}#{Time.now}")
        @current_user.save
        UserMailer.confirm(@current_user, @host).deliver_later
      end
    else
      flash[:notice] = "This confirmation token is invalid."
      flash[:color] = "invalid"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :confirmation)
  end
end
