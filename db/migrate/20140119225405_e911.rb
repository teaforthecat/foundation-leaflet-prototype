class E911 < ActiveRecord::Migration
  def change
    create_table :e911s do |t|
      t.string :name
      t.references :account
      t.timestamps
    end
  end
end
