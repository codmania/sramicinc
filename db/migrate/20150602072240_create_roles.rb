class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :authority

      t.timestamps null: false
    end
  end
end
