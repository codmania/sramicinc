class AddIndexToEnquiry < ActiveRecord::Migration
  def change
    add_index :enquiries, :enquiry_category_id
  end
end
