class CreateTalentAlerts < ActiveRecord::Migration
  def change
    create_table :talent_alerts do |t|
      t.string :what
      t.string :where
      t.string :within
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
