class AddLogoToEprofile < ActiveRecord::Migration
  def change
    add_attachment :eprofiles, :logo
  end
end
