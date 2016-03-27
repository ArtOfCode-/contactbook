class Contact < ActiveRecord::Base
  attr_accessor :encrypted_fields
  
  encrypted_fields = ['first', 'last', 'title', 'city', 'phone', 'email']
end
