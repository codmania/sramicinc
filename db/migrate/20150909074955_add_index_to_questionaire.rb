class AddIndexToQuestionaire < ActiveRecord::Migration
  def change
    add_index :questionaires, :user_id
    add_index :questionaires,:eprofile_id
  end
end
