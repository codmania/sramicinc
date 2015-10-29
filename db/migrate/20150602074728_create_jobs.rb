class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.references :employer
      t.timestamps null: false
    end
  end
end
