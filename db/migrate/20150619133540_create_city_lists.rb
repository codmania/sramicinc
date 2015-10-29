class CreateCityLists < ActiveRecord::Migration
  def change
    create_table :city_lists do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
