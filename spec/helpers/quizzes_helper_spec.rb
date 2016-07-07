require 'rails_helper'

RSpec.describe QuizzesHelper, type: :helper do
	before do 
		User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		Quiz.create!(:id => 1, :name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
		Question.create!(:id => 1, :contect => "Respond properly to the exercises", :quiz_id => 1)
		Answer.create!(:id => 1, :type => "Correct", :contect => "10", :question_id => 1)
		Answer.create!(:id => 2, :type => "Incorrect", :contect => "7 pizzas", :question_id => 1)
	end
  	describe '#evaluate_number_or_string' do 
		context 'evaluate the client arswer number or string' do
		    it 'returns true' do
		    	answer = Answer.find(1)
		    	player_answer = "10"
		      	expect(helper.evaluate_number_or_string answer, player_answer).to eq true
		    end

		    it 'returns true' do
		    	answer = Answer.find(1)
		    	player_answer = "ten"
		      	expect(helper.evaluate_number_or_string answer, player_answer).to eq true
		    end

		    it 'returns false' do
		    	answer = Answer.find(1)
		    	player_answer = "1"
		      	expect(helper.evaluate_number_or_string answer, player_answer).to eq false
		    end

		    it 'returns false' do
		    	answer = Answer.find(1)
		    	player_answer = "one"
		      	expect(helper.evaluate_number_or_string answer, player_answer).to eq false
		    end

		    it 'returns false' do
		    	answer = Answer.find(2)
		    	player_answer = "7"
		      	expect(helper.evaluate_number_or_string answer, player_answer).to eq false
		    end

		    it 'returns nil' do
		    	answer = Answer.find(2)
		    	player_answer = "seven"
		      	expect(helper.evaluate_number_or_string answer, player_answer).to eq nil
		    end

		    it 'returns true' do
		    	answer = Answer.find(2)
		    	player_answer = "7 pizzas"
		      	expect(helper.evaluate_number_or_string answer, player_answer).to eq true
		    end
		end
	end

	describe '#basic_evaluate' do
		context 'evaluate the client arswer' do
		    it 'returns true' do
		    	answer = Answer.find(1)
		      	expect(helper.basic_evaluate answer).to eq true
		    end

		    it 'returns false' do
		    	answer = Answer.find(2)
		      	expect(helper.basic_evaluate answer).to eq false
		    end
		end
	end
end
