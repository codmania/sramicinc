class AddActiveToJprofiles < ActiveRecord::Migration
  def change
    add_column :jprofiles, :active, :boolean, default: true
  end
end
