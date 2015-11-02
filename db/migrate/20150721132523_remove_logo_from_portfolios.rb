class RemoveLogoFromPortfolios < ActiveRecord::Migration
  def change
  	remove_column :portfolios, :logo
  end
end
