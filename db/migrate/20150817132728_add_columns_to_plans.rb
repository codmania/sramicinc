class AddColumnsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :job_post, :integer
    add_column :plans, :resume_database, :integer
    add_column :plans, :user_account, :integer
    add_column :plans, :analytics, :boolean, :default => false
    add_column :plans, :email_support, :boolean, :default => false
    add_column :plans, :phone_support, :boolean, :default => false
    add_column :plans, :api, :boolean, :default => false
    add_column :plans, :profile_alert, :boolean, :default => false



  end
end
