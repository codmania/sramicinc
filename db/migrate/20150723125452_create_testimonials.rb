class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :user_id
      t.string :name
      t.string :email
      t.string :company
      t.text :description
      t.timestamps null: false
    end
  end
end
