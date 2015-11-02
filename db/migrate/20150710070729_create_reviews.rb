class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :from
      t.text :pros
      t.text :cons
      t.text :recommendations
      t.integer :to
      t.string :ratings
      t.timestamps null: false
    end
  end
end
