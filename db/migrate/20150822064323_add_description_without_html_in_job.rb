class AddDescriptionWithoutHtmlInJob < ActiveRecord::Migration
  def change
    add_column :jobs, :plain_description, :text
  end
end
