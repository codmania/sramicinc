class AddDetailsColumnsToJob < ActiveRecord::Migration
  def change
  add_column :jobs,:description,:text

  add_column :jobs,:education,:string
  add_column :jobs,:experience,:string
  add_column :jobs,:industry_id,:integer
  add_column :jobs,:keywords,:string
  add_column :jobs, :city, :string
  add_column :jobs, :state_list_id, :integer
  add_column :jobs, :country_list_id, :integer
  add_column :jobs, :zip, :string
  add_column :jobs, :job_type_id, :integer

  add_column :jobs,:salary_type_id,:integer
  add_column :jobs,:salary,:integer
  add_column :jobs,:job_length,:integer
  add_column :jobs,:relocation,:boolean
  add_column :jobs,:certification,:string
  add_column :jobs,:clearance,:string
  add_column :jobs,:category_id,:integer
  add_column :jobs,:references,:string
  add_column :jobs,:status,:boolean, :default => true

  end
end
