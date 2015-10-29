class AddLogoToPortfolios < ActiveRecord::Migration
  def change
  	 add_attachment :portfolios, :logo
  end
end
