class CreateCountryLists < ActiveRecord::Migration
  def change
    create_table :country_lists do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
