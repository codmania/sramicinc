class AddIndexToJobAlert < ActiveRecord::Migration
  def change
    add_index :job_alerts, :user_id
  end
end
