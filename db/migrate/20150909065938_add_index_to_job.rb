class AddIndexToJob < ActiveRecord::Migration
  def change

    add_index :jobs, :employer_id
    add_index :jobs, :industry_id
    add_index :jobs, :category_id
    add_index :jobs, :state_list_id
    add_index :jobs, :country_list_id
    add_index :jobs, :salary_type_id
    add_index :jobs, :job_type_id

  end
end
