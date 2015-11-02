class AddEmployerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :employer_id, :integer, default: nil
  end
end
