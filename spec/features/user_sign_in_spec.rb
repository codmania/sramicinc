require 'rails_helper'

feature 'User signs in', :js=>true do
  
  before :each do
    if Role.count==0
      load Rails.root + "db/seeds.rb" 
    end
  end
  
  scenario 'login with jobseeker credentials' do
    visit new_user_session_path
    fill_in 'user[email]', with:'jobseeker1@gmail.com'
    fill_in 'user[password]', with:'sigma@123'
    click_on 'Log in'
    expect(page).to have_content('jobseeker 1')
  end  
end