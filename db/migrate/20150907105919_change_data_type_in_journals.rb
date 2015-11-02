class ChangeDataTypeInJournals < ActiveRecord::Migration
  def change
    change_column :journals, :name, :text
    change_column :journals, :reference, :text
  end
end
