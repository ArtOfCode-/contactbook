class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_action :set_user, :only => [:admin_options, :admin_edit, :admin_delete]
  before_action :verify_admin, :only => [:index, :admin_options, :admin_edit, :admin_delete]
  before_action :authenticate_user, :only => [:confirm]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_confirmed = false
    @user.confirmation_token = Digest::SHA2.new(256).hexdigest("#{@user.created_at}#{@user.username}#{Time.now}")
    if @user.save
      UserMailer.confirm(@user, @host).deliver_later
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

  def admin_options
  end

  def admin_edit
    if @user.update(admin_edit_params)
      flash[:notice] = "User was successfully updated."
      flash[:color] = "valid"
    else
      flash[:notice] = "User was not updated."
      flash[:color] = "invalid"
    end
    render :admin_options
  end

  def admin_delete
    if !params[:dc].nil? && params[:dc] == 1
      posts = Post.where(:created_by => @user.id)
      posts.each do |post|
        post.destroy
      end
      content = true
    end
    @user.destroy
    redirect_to url_for(:controller => :users, :action => :index)
    flash[:notice] = "User #{content ? 'and content ' : ''}successfully destroyed."
    flash[:color] = "valid"
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :confirmation)
    end

    def admin_edit_params
      params.require(:user).permit(:is_confirmed, :is_admin, :username)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
