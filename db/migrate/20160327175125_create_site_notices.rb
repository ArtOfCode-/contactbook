class CreateSiteNotices < ActiveRecord::Migration
  def change
    create_table :site_notices do |t|
      t.string :text
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
