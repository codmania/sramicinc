class CreateReviewResponses < ActiveRecord::Migration
  def change
    create_table :review_responses do |t|
      t.integer :from
      t.integer :review_id
      t.text :response
      t.timestamps null: false
    end
  end
end
