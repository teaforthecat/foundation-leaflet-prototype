class AddGeoIdToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :geo, index: true
  end
end
