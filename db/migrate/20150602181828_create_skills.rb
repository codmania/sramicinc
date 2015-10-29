class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|

      t.integer :year_of_experience
      t.string :name
      #t.integer :last_used_year
      #t.references :skill_set

      t.references :jprofile
      t.timestamps null: false
    end
  end
end
