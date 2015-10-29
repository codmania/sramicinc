class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.string :url
      t.string :logo
      t.references :jprofile

      t.timestamps null: false
    end
  end
end
