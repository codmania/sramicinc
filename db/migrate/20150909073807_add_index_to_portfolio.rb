class AddIndexToPortfolio < ActiveRecord::Migration
  def change
    add_index :portfolios, :jprofile_id
  end
end
