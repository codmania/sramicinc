class UpdateYearsofexperienceToSkills < ActiveRecord::Migration
  def change
    change_column :skills, :year_of_experience,:string,:default=>0
  end
end
