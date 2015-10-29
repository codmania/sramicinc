class SecurityQuestionsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :security_question_id, :integer
    add_column :users, :security_question_answer, :string
  end
end
