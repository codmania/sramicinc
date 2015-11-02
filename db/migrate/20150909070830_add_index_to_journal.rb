class AddIndexToJournal < ActiveRecord::Migration
  def change
    add_index :journals, :jprofile_id
  end
end
