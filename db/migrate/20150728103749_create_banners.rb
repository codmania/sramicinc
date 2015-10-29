class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.string :url
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
