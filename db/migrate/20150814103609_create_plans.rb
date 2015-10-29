class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name

      t.float :price
      t.float :days
      t.string :description
      t.string :plan_type   # [Employer, Jobseeker]

      t.timestamps null: false
    end
  end
end
