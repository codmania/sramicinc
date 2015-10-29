class AddIndexToEmailTemplate < ActiveRecord::Migration
  def change
    add_index :email_templates, :employer_id
  end
end
