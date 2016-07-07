require 'rails_helper'

RSpec.describe Quiz, type: :model do

	before do
		registered_user = User.new(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		registered_user.save
	end

	describe "is valid to save" do 
	  	it "has all parameters needed to be saved" do 
			quiz = Quiz.new(:name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
			expect(quiz.save).to be true 
		end
	end

	describe "is not valid to save" do

		it "it has a validation for name attribute" do 
			quiz = Quiz.new(:name => nil, :description => "Respond properly to the exercises", :user_id => 1)
			expect(quiz.save).to be false 
		end
		it "it has a validation for description attribute" do 
			quiz = Quiz.new(:name => "Math", :description => nil, :user_id => 1)
			expect(quiz.save).to be false 
		end
		it "it has a validation for user_id presence" do 
			quiz = Quiz.new(:name => "Math", :description => "Respond properly to the exercises", :user_id => nil)
			expect(quiz.save).to be false 
		end

	end

	it "has a association with Question model" do 
		quiz = Quiz.reflect_on_association(:questions)
    	expect(quiz.macro) == :has_many
	end

	it "has a association with Question model" do 
		quiz = Quiz.reflect_on_association(:user)
    	expect(quiz.macro) == :belongs_to
	end
end
