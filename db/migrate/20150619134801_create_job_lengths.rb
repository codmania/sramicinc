class CreateJobLengths < ActiveRecord::Migration
  def change
    create_table :job_lengths do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
