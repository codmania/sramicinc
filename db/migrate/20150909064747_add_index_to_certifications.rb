class AddIndexToCertifications < ActiveRecord::Migration
  def change
    add_index :certifications, :jprofile_id
  end
end
