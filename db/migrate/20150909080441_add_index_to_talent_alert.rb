class AddIndexToTalentAlert < ActiveRecord::Migration
  def change
    add_index :talent_alerts,:user_id
  end
end
