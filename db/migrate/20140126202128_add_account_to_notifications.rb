class AddAccountToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :account, index: true
  end
end
