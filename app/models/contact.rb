class Contact < ActiveRecord::Base
  def encrypted_fields
    return ['first', 'last', 'title', 'city', 'phone', 'email']
  end
end
