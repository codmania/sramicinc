class AddIndexToProfileHire < ActiveRecord::Migration
  def change
    add_index :profile_hires, :employer_id
    add_index :profile_hires, :jprofile_id
  end
end
