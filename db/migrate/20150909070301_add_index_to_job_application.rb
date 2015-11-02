class AddIndexToJobApplication < ActiveRecord::Migration
  def change
    add_index :job_applications, :job_id
    add_index :job_applications, :jobseeker_id

  end
end
