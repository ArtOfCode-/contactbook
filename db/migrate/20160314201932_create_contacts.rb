class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first
      t.string :last
      t.string :title
      t.string :city
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
