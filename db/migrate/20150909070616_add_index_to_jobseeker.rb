class AddIndexToJobseeker < ActiveRecord::Migration
  def change
    add_index :jobseekers, :user_id
  end
end
