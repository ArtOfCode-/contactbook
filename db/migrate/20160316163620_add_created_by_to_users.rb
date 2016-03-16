class AddCreatedByToUsers < ActiveRecord::Migration
  def change
    add_column :contacts, :created_by, :integer, null: false
  end
end
