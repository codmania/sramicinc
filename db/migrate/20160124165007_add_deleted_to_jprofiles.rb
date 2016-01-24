class AddDeletedToJprofiles < ActiveRecord::Migration
  def change
    add_column :jprofiles, :deleted, :boolean, default: false
  end
end
