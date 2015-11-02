class AddIndexToTestimonial < ActiveRecord::Migration
  def change
    add_index :testimonials,:user_id
  end
end
