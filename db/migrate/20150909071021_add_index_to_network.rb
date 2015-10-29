class AddIndexToNetwork < ActiveRecord::Migration
  def change
    add_index :networks, :user_id
  end
end
