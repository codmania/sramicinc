class AddIndexToJcontact < ActiveRecord::Migration
  def change
    add_index :jcontacts, :employer_id
    add_index :jcontacts, :job_application_id

  end
end
