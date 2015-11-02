class CreateJcontacts < ActiveRecord::Migration
  def change
    create_table :jcontacts do |t|
      t.text :message
      t.integer :employer_id
      t.integer :job_application_id
      t.integer :thread_parent,:default=>nil
      t.boolean :is_read,:default=>false
      t.timestamps null: false
    end
  end
end
