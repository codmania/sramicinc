class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
    	t.integer :user_id
      t.integer :me
      t.timestamps null: false

    end
  end
end
