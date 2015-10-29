class CreateJobseekers < ActiveRecord::Migration
  def change
    create_table :jobseekers do |t|
      t.string :name
      t.boolean :active, :default => true
      t.references :user
      t.timestamps null: false
    end
  end
end
