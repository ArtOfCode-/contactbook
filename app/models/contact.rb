class Contact < ActiveRecord::Base 
  def self.encrypted_fields
    return ['first', 'last', 'title', 'city', 'phone', 'email']
  end
end
