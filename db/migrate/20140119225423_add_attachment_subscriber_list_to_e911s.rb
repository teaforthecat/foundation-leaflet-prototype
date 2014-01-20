class AddAttachmentSubscriberListToE911s < ActiveRecord::Migration
  def self.up
    change_table :e911s do |t|
      t.attachment :subscriber_list
    end
  end

  def self.down
    drop_attached_file :e911s, :subscriber_list
  end
end
