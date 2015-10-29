class AddCountryColumnToStateLists < ActiveRecord::Migration
  def change
    add_column :state_lists, :country_list_id, :integer
  end
end
