class AddResponddateToEnquiries < ActiveRecord::Migration
  def change
  	 add_column :enquiries, :respond_date, :date
  end
end
