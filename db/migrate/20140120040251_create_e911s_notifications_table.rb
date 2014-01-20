class CreateE911sNotificationsTable < ActiveRecord::Migration
  def change
    create_table :e911s_notifications do |t|
      t.references :e911, index: true
      t.references :notification, index: true
    end
  end
end
