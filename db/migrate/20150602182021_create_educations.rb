class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|

      # t.boolean :is_highest_qualification
      # t.string :title
      #
      #
      # t.integer :year_attained
      # t.integer :qualification_id
      # t.integer :university_id
      # t.integer :discipline_id
      # t.integer :grade_id

      t.string :degree
      t.string :field
      t.string :institution
      t.string :location
      t.string :completion


      t.references :jprofile
      t.timestamps null: false
    end
  end
end
