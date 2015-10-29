class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :name
      t.string :institution
      t.date :received
      t.date :expired

      t.references :jprofile

      t.timestamps null: false
    end
  end
end
