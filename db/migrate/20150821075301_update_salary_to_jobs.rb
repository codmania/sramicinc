class UpdateSalaryToJobs < ActiveRecord::Migration
  def change
  change_column :jobs, :salary ,:string
  end
end
