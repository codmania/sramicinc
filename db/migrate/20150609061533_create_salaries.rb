class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.string :amount

      t.timestamps null: false
    end
  end
end
