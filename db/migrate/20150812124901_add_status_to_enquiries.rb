class AddStatusToEnquiries < ActiveRecord::Migration
  def change
  	add_column :enquiries,:status,:string ,:default => 'pending'
      end
end
