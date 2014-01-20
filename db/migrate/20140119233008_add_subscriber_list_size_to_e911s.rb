class AddSubscriberListSizeToE911s < ActiveRecord::Migration
  def change
    add_column :e911s, :subscriber_list_row_count, :integer
  end
end
