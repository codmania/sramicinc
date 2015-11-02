class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :name
      t.references :user
      t.timestamps null: false
    end
  end
end
