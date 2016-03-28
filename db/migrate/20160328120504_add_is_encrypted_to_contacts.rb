class AddIsEncryptedToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :is_encrypted, :boolean
  end
end
