class AddIndexToSkill < ActiveRecord::Migration
  def change
    add_index :skills, :jprofile_id
  end
end
