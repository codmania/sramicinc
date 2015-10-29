class CreateProfileHires < ActiveRecord::Migration
  def change
    create_table :profile_hires do |t|
      t.integer :employer_id
      t.integer :jprofile_id
      t.boolean :is_recruited, :default=>false
      t.timestamps null: false
    end
  end
end
