class AddNotificationIdToGeos < ActiveRecord::Migration
  def change
    add_reference :geos, :notification, index: true
  end
end
