class Contact < ActiveRecord::Base
  encrypted_fields = ['first', 'last', 'title', 'city', 'phone', 'email']
end
