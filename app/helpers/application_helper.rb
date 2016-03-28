module ApplicationHelper
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
      if Contact.encrypted_fields.include?(name)
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
      if Contact.encrypted_fields.include?(name)
        contact[name] = rijndael.encrypt(value)
      end
    end
    return contact
  end
end
