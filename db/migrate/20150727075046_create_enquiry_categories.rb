class CreateEnquiryCategories < ActiveRecord::Migration
  def change
    create_table :enquiry_categories do |t|
    	t.string :name

      t.timestamps null: false
    end
  end
end
