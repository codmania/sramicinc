class AddIndexToCarts < ActiveRecord::Migration
  def change
    add_index :carts, :job_id
    add_index :carts, :jobseeker_id

  end
end
