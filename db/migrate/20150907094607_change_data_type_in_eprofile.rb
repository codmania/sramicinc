class ChangeDataTypeInEprofile < ActiveRecord::Migration
  def change
    change_column :eprofiles, :services, :text
    change_column :eprofiles, :products, :text
    change_column :eprofiles, :address1, :text
    change_column :eprofiles, :address2, :text
    change_column :eprofiles, :website, :text
    change_column :eprofiles, :fb_url, :text
    change_column :eprofiles, :twitter_url, :text
    change_column :eprofiles, :gplus_url, :text
    change_column :eprofiles, :linkedin_url, :text
  end
end
