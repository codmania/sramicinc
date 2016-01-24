class AddStatusFieldsToEprofiles < ActiveRecord::Migration
  def change
    add_column :eprofiles, :active, :boolean, default: true
    add_column :eprofiles, :deleted, :boolean, default: false
    add_column :eprofiles, :publicviewing, :boolean, default: true
  end
end
