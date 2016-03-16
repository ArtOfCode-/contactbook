class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :title
      t.string :first null: false
      t.string :last null: false
      t.string :city
      t.string :phone
      t.string :email
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
