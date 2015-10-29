class AddCaptchaToUsers < ActiveRecord::Migration
  def change
  	add_column :users,:captcha,:string 
  	add_column :users,:captcha_key,:string
  end
end
