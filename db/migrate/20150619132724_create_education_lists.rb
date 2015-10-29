class CreateEducationLists < ActiveRecord::Migration
  def change
    create_table :education_lists do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
