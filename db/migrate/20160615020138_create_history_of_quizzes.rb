class CreateHistoryOfQuizzes < ActiveRecord::Migration
  def change
    create_table :history_of_quizzes do |t|
  	t.belongs_to :user, 		index: true
		t.string 		 :quiz_id
    t.string     :name
		t.string 		 :number_of_question
		t.string 		 :number_of_correct_answers

      t.timestamps null: false
    end
    add_foreign_key :history_of_quizzes, :users
  end
end
