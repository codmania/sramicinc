class CreateWatchLists < ActiveRecord::Migration
  def change
    create_table :watch_lists do |t|
      t.integer :job_id
      t.integer :jobseeker_id

      t.timestamps null: false
    end
  end
end
