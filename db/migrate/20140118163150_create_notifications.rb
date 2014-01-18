class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :dcm_topic_id
      t.string :dcm_account_code

      t.timestamps
    end
    add_index :notifications, :dcm_account_code, unique: true
  end
end
