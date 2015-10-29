class AddDefaultValuesToPlans < ActiveRecord::Migration
  def change
    change_column :plans, :days, :float, :default => 0
    change_column :plans, :price, :float, :default => 0
  end
end
