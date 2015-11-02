class CreateStateLists < ActiveRecord::Migration
  def change
    create_table :state_lists do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
