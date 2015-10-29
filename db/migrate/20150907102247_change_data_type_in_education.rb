class ChangeDataTypeInEducation < ActiveRecord::Migration
  def change
    change_column :educations, :location, :text
  end
end
