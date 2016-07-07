require 'rails_helper'

RSpec.describe User, type: :model do

	before do
		registered_user = User.new(:email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		registered_user.save
	end

	describe "registration requirements" do
		
		it "has a validation for email presence" do 
			user = User.new(:email => nil, :password => 'ableton10', :type => "Teacher")
			expect(user.save).to be false 
		end

		it "has a validation for password presence" do 
			user = User.new(:email => 'armando1339@gmail.com', :password => nil, :type => "Teacher")
			expect(user.save).to be false
		end

		it "has a validation for type presence" do 
			user = User.new(:email => 'armando1339@gmail.com', :password => 'ableton10', :type => nil)
			expect(user.save).to be false
		end

		it "email attribute is unique" do 
			user = User.new(:email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Student")
			expect(user.save).to be false
		end

	end

	it { expect(User.subclasses_array_options).to eq ["Teacher", "Student"] }

	it "has a association with Quiz model" do 
		user = User.reflect_on_association(:quizzes)
    	expect(user.macro) == :has_many
	end

	it "has a association with HistoryOfQuiz model" do 
		user = User.reflect_on_association(:history_of_quizzes)
    	expect(user.macro) == :has_many
	end
end
