class CreateSearchFilters < ActiveRecord::Migration
  def change
    create_table :search_filters do |t|
      t.string :name
      t.integer :user_id
      t.string :criteria

      t.timestamps null: false
    end
  end
end
