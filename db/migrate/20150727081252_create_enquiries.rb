class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
    	t.integer :enquiry_category_id
    	t.string :name
    	t.string :email
    	t.text  :description
        t.timestamps null: false
    end
  end
end
