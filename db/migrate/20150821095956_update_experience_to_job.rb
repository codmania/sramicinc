class UpdateExperienceToJob < ActiveRecord::Migration
  def change
    change_column :jobs, :experience,:string,:default=>0
  end
end
