class RemoveSummaryFromJprofiles < ActiveRecord::Migration
  def change
    remove_column :jprofiles, :summary, :string
  end
end
