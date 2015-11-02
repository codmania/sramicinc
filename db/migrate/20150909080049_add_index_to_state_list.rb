class AddIndexToStateList < ActiveRecord::Migration
  def change
    add_index :state_lists, :country_list_id
  end
end
