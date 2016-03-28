class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_login_status
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

    def check_login_status
      if session[:user_id]
        @current_user = User.find session[:user_id]
        return true
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
      if flash[:preserve_notice].nil? || flash[:preserve_notice] == false
        flash[:notice] = nil
        flash[:color] = nil
      end
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

    def decrypt_contacts(contacts)
      authenticate_user
      if session[:dek].nil?
        flash[:notice] = "There was an error with your session; please log in again."
        flash[:color] = "invalid"
        flash[:preserve_notice] = true
        redirect_to url_for(:controller => :sessions, :action => :logout)
        return
      end
      return decrypt_contacts_helper(contacts)
    end

    def encrypt_contacts(contacts)
      authenticate_user
      if session[:dek].nil?
        flash[:notice] = "There was an error with your session; please log in again."
        flash[:color] = "invalid"
        flash[:preserve_notice] = true
        redirect_to url_for(:controller => :sessions, :action => :logout)
        return
      end
      return encrypt_contacts_helper(contacts)
    end


  private
    def decrypt_contacts_helper(contacts)
      if contacts.respond_to?(:each_with_index)
        contacts.each_with_index do |contact, index|
          contacts[index] = decrypt_single_helper(contact)
        end
        return contacts
      else
        return decrypt_single_helper(contacts)
      end
    end

    def decrypt_single_helper(contact)
      rijndael = Rijndael::Base.new(session[:dek])
      contact.attributes.each do |name, value|
        if Contact.encrypted_fields.include?(name) && !value.nil? && value != ""
          contact[name] = rijndael.decrypt(value)
        end
      end
      return contact
    end

    def encrypt_contacts_helper(contacts)
      if contacts.respond_to?(:each_with_index)
        contacts.each_with_index do |contact, index|
          contacts[index] = encrypt_single_helper(contact)
        end
        return contacts
      else
        return encrypt_single_helper(contacts)
      end
    end

    def encrypt_single_helper(contact)
      rijndael = Rijndael::Base.new(session[:dek])
      contact.attributes.each do |name, value|
        if Contact.encrypted_fields.include?(name) && !value.nil? && value != ""
          contact[name] = rijndael.encrypt(value)
        end
      end
      return contact
    end
end
