class CreateSkillSets < ActiveRecord::Migration
  def change
    create_table :skill_sets do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
