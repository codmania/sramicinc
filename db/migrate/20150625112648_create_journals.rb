class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :name
      t.date :date
      t.string :reference

      t.references :jprofile
      t.timestamps null: false
    end
  end
end
