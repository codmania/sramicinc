class AddIndexToBookmark < ActiveRecord::Migration
  def change
    add_index :bookmarks, :jobseeker_id
    add_index :bookmarks, :employer_id
  end
end
