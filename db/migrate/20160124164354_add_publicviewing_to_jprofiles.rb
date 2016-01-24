class AddPublicviewingToJprofiles < ActiveRecord::Migration
  def change
    add_column :jprofiles, :publicviewing, :boolean, default: true
  end
end
