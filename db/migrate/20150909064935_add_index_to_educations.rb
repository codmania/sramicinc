class AddIndexToEducations < ActiveRecord::Migration
  def change
    add_index :educations, :jprofile_id
  end
end
