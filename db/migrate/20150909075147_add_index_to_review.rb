class AddIndexToReview < ActiveRecord::Migration
  def change
    add_index :reviews, :from
    add_index :reviews, :to
  end
end
