class ChangeDataTypeInJprofile < ActiveRecord::Migration
  def change
    change_column :jprofiles, :address1, :text
    change_column :jprofiles, :address2, :text
    change_column :jprofiles, :summary, :text
  end
end
