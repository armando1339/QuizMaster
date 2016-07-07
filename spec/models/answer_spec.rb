require 'rails_helper'

RSpec.describe Answer, type: :model do

	before do
		registered_user = User.new(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		registered_user.save
		registered_quiz = Quiz.new(:id => 1, :name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
		registered_quiz.save
		registered_question = Question.new(:id => 1, :contect => "Respond properly to the exercises", :quiz_id => 1)
		registered_question.save
	end

	describe "is valid to save" do
		it "it has all parameters needed to be saved" do
			answer = Answer.new(:type => "Correct", :contect => "5", :question_id => 1)
			expect(answer.save).to be true
		end
	end

	describe "is not valid to save" do 
		it "it has a validation for type attribute" do 
			answer = Answer.new(:type => nil, :contect => "5", :question_id => 1)
			expect(answer.save).to be false
		end
		it "it has a validation for contect attribute" do 
			answer = Answer.new(:type => "Correct", :contect => nil, :question_id => 1)
			expect(answer.save).to be false
		end
		it "it has a validation for question_id attribute" do 
			answer = Answer.new(:type => "Incorrect", :contect => "5", :question_id => nil)
			expect(answer.save).to be false
		end
	end

	describe "validate answer type correct with uniqueness." do
		before do 
			registered_answer = Answer.new(:type => "Correct", :contect => "5", :question_id => 1)
			registered_answer.save
		end

		it "a question only can have one correct aswer" do 
			answer = Answer.new(:type => "Correct", :contect => "5", :question_id => 1)
			expect(answer.save).to be false
		end
	end

	it "has a association with HistoryOfQuiz model" do 
		user = Answer.reflect_on_association(:question)
    	expect(user.macro) == :belongs_to
	end
  
end
