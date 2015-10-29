class AddIndexToEmployers < ActiveRecord::Migration
  def change
    add_index :employers, :user_id
  end
end
