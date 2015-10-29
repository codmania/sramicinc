class AddIndexToReviewResponse < ActiveRecord::Migration
  def change
    add_index :review_responses, :review_id
  end
end
