class AddLogoToJprofile < ActiveRecord::Migration

  def change
    add_attachment :jprofiles, :logo
  end

end
