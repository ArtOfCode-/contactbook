class AddIsConfirmedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_confirmed, :boolean
  end
end
