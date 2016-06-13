class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :name
      t.text :description
      t.belongs_to 	:user, 		index: true

      t.timestamps null: false
    end
    add_foreign_key :quizzes, :users
  end
end
