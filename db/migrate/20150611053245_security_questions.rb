class SecurityQuestions < ActiveRecord::Migration
  def change
  	create_table :security_questions do |t|
	  t.string :locale, :null => false
	  t.string :name, :null => false
	end
	SecurityQuestion.create! locale: :en, name: "What is your mother's maiden name?"
	SecurityQuestion.create! locale: :en, name: 'Where are you born?'
	SecurityQuestion.create! locale: :en, name: 'What is the name of your first pet?'
	SecurityQuestion.create! locale: :en, name: 'Which is your favorite movie?'
	SecurityQuestion.create! locale: :en, name: 'Which is your favorite book?'
	SecurityQuestion.create! locale: :en, name: 'Which is your favorite animal?'
	SecurityQuestion.create! locale: :en, name: 'Which is your favorite travel destination?'
  end
end
