class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :contect
      t.belongs_to 	:quiz, 		index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :quizzes
  end
end
