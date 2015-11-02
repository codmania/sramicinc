class AddSummaryToJprofiles < ActiveRecord::Migration
  def change
    add_column :jprofiles, :summary, :text
  end
end
