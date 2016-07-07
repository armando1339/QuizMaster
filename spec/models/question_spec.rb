require 'rails_helper'

RSpec.describe Question, type: :model do

	before do
		registered_user = User.new(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		registered_user.save
		registered_quiz = Quiz.new(:id => 1, :name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
		registered_quiz.save
	end

	describe "is valid to save" do
		it "it has all parameters needed to be saved" do
			question = Question.new(:contect => "Respond properly to the exercises", :quiz_id => 1)
			expect(question.save).to be true
		end
	end

	describe "is not valid to save" do 
		it "it has a validation for contect attribute" do 
			question = Question.new(:contect => nil, :quiz_id => 1)
			expect(question.save).to be false 
		end

		it "it has a validation for quiz_id attribute" do 
			question = Question.new(:contect => "Respond properly to the exercises", :quiz_id => nil)
			expect(question.save).to be false 
		end
	end
  
  	it "has a association with Answers model" do 
		question = Question.reflect_on_association(:answers)
    	expect(question.macro) == :has_many
	end

	it "has a association with Quiz model" do 
		question = Question.reflect_on_association(:quiz)
    	expect(question.macro) == :belongs_to
	end
end
