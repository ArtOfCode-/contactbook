class Contact < ActiveRecord::Base
  before_save :encrypt_data

  def encrypt_data
    if @current_user.nil? || session[:dek].nil?
      flash[:notice] = "There was an error with your session; please log in again."
      flash[:color] = "invalid"
      flash[:preserve_notice] = true
    else
      # TODO: do encryption
    end
  end
end
