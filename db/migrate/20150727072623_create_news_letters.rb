class CreateNewsLetters < ActiveRecord::Migration
  def change
    create_table :news_letters do |t|
      t.string :title
      t.string :name
      t.string :email
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
