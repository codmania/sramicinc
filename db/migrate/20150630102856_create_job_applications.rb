class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.references :jobseeker
      t.references :job
      t.string :status,:default => 'pending'
      t.integer :jcontact_id
      t.boolean :contact,:default=>false
      t.timestamps null: false
    end
  end
end
