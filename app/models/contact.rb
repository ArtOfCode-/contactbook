class Contact < ActiveRecord::Base
  before_save :encrypt_data

  encrypted_fields = ['first', 'last', 'title', 'city', 'phone', 'email']

  def encrypt_data
    if @current_user.nil? || session[:dek].nil?
      flash[:notice] = "There was an error with your session; please log in again."
      flash[:color] = "invalid"
      flash[:preserve_notice] = true
    else
      rijndael = Rijndael::Base.new(session[:dek])
      self.attributes.each do |name, value|
        if self.encrypted_fields.include?(name)
          self[name] = rijdael.encrypt(value)
        end
      end
    end
  end
end
