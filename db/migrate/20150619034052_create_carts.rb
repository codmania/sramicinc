class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
  	t.integer :job_id
    t.integer :jobseeker_id
    t.timestamps null: false
    end
  end
end
