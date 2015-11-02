class AddIndexToWatchList < ActiveRecord::Migration
  def change
    add_index :watch_lists,:job_id
    add_index :watch_lists,:jobseeker_id
  end
end
