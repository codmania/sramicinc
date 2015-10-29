class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :user_id
      t.string :url
      t.string :n_type

      t.timestamps null: false
    end
  end
end
