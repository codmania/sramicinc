class AddIndexToJobHistory < ActiveRecord::Migration
  def change
    add_index :job_histories, :jprofile_id
  end
end
