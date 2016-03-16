class AddCreatedByToUsers < ActiveRecord::Migration
  def change
    add_column :contacts, :created_by, :integer, null: false, default: -1
  end
end
