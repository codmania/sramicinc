class CreateSalaryTypes < ActiveRecord::Migration
  def change
    create_table :salary_types do |t|
      t.string :s_type

      t.timestamps null: false
    end
  end
end
