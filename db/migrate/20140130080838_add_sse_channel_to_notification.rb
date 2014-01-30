class AddSseChannelToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :sse_channel, :string
  end
end
