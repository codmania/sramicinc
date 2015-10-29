class AddIndexToEprofile < ActiveRecord::Migration
  def change
    add_index :eprofiles, :employer_id, unique: true
    add_index :eprofiles, :industry_id
    add_index :eprofiles, :state_list_id
    add_index :eprofiles, :country_list_id
  end
end
