class CreateExperienceSectors < ActiveRecord::Migration
  def change
    create_table :experience_sectors do |t|

      t.references :job_history
      t.timestamps null: false
    end
  end
end
