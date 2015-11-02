class ChangeDataTypeInPortfolio < ActiveRecord::Migration
  def change
    change_column :portfolios, :url, :text
  end
end
