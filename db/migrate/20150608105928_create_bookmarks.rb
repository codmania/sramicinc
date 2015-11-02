class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :jobseeker_id
      t.integer :employer_id

      t.timestamps null: false
    end
  end
end
