class AddResumeToJprofile < ActiveRecord::Migration
  def change
    add_attachment :jprofiles, :resume
  end
end
