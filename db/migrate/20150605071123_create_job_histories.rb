class CreateJobHistories < ActiveRecord::Migration
  def change
    create_table :job_histories do |t|

      #t.string :experience
      t.string :title
      t.string :organization

      t.boolean :currentcompany

      t.date :from
      t.date :to

      t.integer :jprofile_id

      t.timestamps null: false

    end
  end
end
