class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.text :news
      t.integer :eprofile_id

      t.timestamps null: false
    end
  end
end
