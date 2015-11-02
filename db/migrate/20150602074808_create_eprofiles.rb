class CreateEprofiles < ActiveRecord::Migration
  def change
    create_table :eprofiles do |t|
      t.string  :company_name
      # t.boolean :company_type
      t.integer :industry_id
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.integer  :state_list_id
      t.integer  :country_list_id
      t.string  :phone
      t.string :fax
      t.string  :website
      t.string  :email
      t.text    :overview
      t.string  :products
      t.string  :services
      t.string  :fb_url
      t.string  :twitter_url
      t.string  :gplus_url
      t.string  :linkedin_url

      t.references :employer
      t.timestamps null: false
    end
  end
end
