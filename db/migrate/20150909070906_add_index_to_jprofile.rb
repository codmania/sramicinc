class AddIndexToJprofile < ActiveRecord::Migration
  def change
    add_index :jprofiles, :jobseeker_id
    add_index :jprofiles, :salary_type_id
    add_index :jprofiles, :state_list_id
    add_index :jprofiles, :country_list_id
  end
end
