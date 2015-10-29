class CreateJprofiles < ActiveRecord::Migration
  def change
    create_table :jprofiles do |t|


      t.string :availability # String
      t.boolean :relocation # true/false

     # t.integer :city_list
     # t.integer :state_list
     # t.integer :country_list

      t.string :title
      t.string :name
      t.string :phone
      t.string  :address1
      t.string  :address2
      t.string :city
      t.integer :state_list_id
      t.integer :country_list_id
      t.string :zip
      t.string :summary
     

      t.integer :salary_type_id
      t.string :salary

      t.float :latitude
      t.float :longitude
    

      t.references :jobseeker
      t.timestamps null: false

      t.string :resume_headline


    end
  end
end
